---
title: main
date: 2024-11-11
categories: hnv
layout: post
---
# main 훝어보기2

```python
def main(classification_model, data, batch, epoch, save_path, device, gpus, precision, mode, ckpt):
    rename_dir()
    model = ClassficationModel(create_model(classification_model))

    if not os.path.exists(save_path):
        os.makedirs(save_path)

    if device == 'gpu':
        if len(gpus) == 1:
            gpus = [int(gpus)]
        else:
            gpus = list(map(int, gpus.split(',')))
    elif device == 'cpu':
        gpus = 'auto'
        precision = 32
    
    checkpoint_callback = ModelCheckpoint(
        monitor='val_acc',
        mode='max',
        dirpath= f'{save_path}',
        filename= f'{classification_model}-'+'{epoch:02d}-{val_acc:.2f}',
        save_top_k=1,
    )
    early_stopping = EarlyStopping(
        monitor='val_acc',
        mode='max',
        patience=10
    )
    wandb_logger = WandbLogger(project="ImageNet")
    
    if mode == 'train':
        trainer = L.Trainer(
            accelerator=device,
            devices=gpus,
            max_epochs=epoch,
            precision=precision,
            logger=wandb_logger,
            callbacks=[checkpoint_callback, early_stopping],
        )
        trainer.fit(model, ImageNetDataModule(data, batch))
        trainer.test(model, ImageNetDataModule(data, batch))
    else:
        trainer = L.Trainer(
            accelerator=device,
            devices=gpus,
            precision=precision
        )
        model = ClassficationModel.load_from_checkpoint(ckpt, model=create_model(classification_model))
        pred_cls, img = trainer.predict(model, ImageNetDataModule(data, mode='predict'))[0]
        txt_path = '../dataset/folder_num_class_map.txt'
        classes_map = pd.read_table(txt_path, header=None, sep=' ')
        classes_map.columns = ['folder', 'number', 'classes']
        
        pred_label = classes_map['classes'][pred_cls.item()]
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        img = cv2.resize(img, (800, 600))
        cv2.putText(
            img,
            f'Predicted class: "{pred_cls[0]}", Predicted label: "{pred_label}"',
            (50, 50),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.8,
            (0, 0, 0),
            2
        )
        cv2.imshow('Predicted output', img)
        cv2.waitKey(0)
        cv2.destroyAllWindows()
```

- `rename_dir()`는 src.utils 에서 정의함
- ` ClassficationModel()` 는 `./` 에서 정의되어 있는 class
    - `create_model` 은 src.utils 에서 정의함
    - `classfication_model`은  `args.model` if __name__ == "__main__" 에서 정의됨

```python
    if not os.path.exists(save_path):
        os.makedirs(save_path)
```
- `save_path`라는 디렉토리가 존재하지 않을 경우, 해당 디렉토리를 생성하는 역할을 합니다.
    - `save_path`가 다중 디렉토리 구조일 경우 (예: "dir1/dir2/dir3"), 중간 경로(dir1, dir2)도 함께 생성해줍니다.

```python
if device == 'gpu':
        if len(gpus) == 1:
            gpus = [int(gpus)]
        else:
            gpus = list(map(int, gpus.split(',')))
    elif device == 'cpu':
        gpus = 'auto'
        precision = 32
```
- 터미널에서 `-dc gpu`를 했을 경우 `- g`로 받은 인자 값(default = 0)이 1 이상이면 리스트로 들어오니깐 그걸 정수로 처리해주고 `-dc gpu`가 아닌 경우 `gpus = 'auto'`로 gpu가 아닌 cpu를 사용한다고 지정  
- `precision = 32` 로 해서 정밀도를 32로 만듬  


```python
checkpoint_callback = ModelCheckpoint(
        monitor='val_acc',
        mode='max',
        dirpath= f'{save_path}',
        filename= f'{classification_model}-'+'{epoch:02d}-{val_acc:.2f}',
        save_top_k=1,
    )
```
- `ModelCheckpoint()`는 `lightning.pytorch.callbacks`에서 가져온 함수
    -  PyTorch Lightning에서 모델 학습 중 모델의 상태를 저장하는 콜백
    - 학습 도중 또는 에포크가 끝날 때마다 특정 조건에 따라 모델을 자동으로 저장하며, 주로 성능이 가장 좋은 모델을 저장하는 데 사용
    - `monitor = 'val_acc'` 기준 메트릭을 `val_loss`로 지정
    - `mode = 'max` 기준 메트릭이 최대값일 때 저장
    - `dirpath = f'{save_path}` 체크포인트 파일이 저장될 경로
    - `filename = f'{}'` 저장되는 파일의 이름을 지정
    - `save_top_k =1`  모델 학습 중에 체크포인트로 저장할 가중치의 개수를 지정, 1로 설정하면 가장 성능이 좋은 가중치만 하나 저장하고, -1로 설정하면 모든 에포크의 가중치를 저장 


```python
    early_stopping = EarlyStopping(
        monitor='val_acc',
        mode='max',
        patience=10
    )
```
- `EarlyStopping()`은 Pytorch Lightning에서 학습 도중 모델의 성능 개선이 더 이상 이루어지지 않을 때 학습을 조기에 종료하는 콜백으로 과적합을 방지하고 학습 시간을 절약해준다.
    - `monitor ='val_acc'` 개선 여부를 평가할 기준이 되는 메트릭
    - `mode = max` 메트릭이 최대값이 될 때 
    - `patience =10` 지정된 메트릭이 개선되지 않을 경우, 몇 에포크 동안 기다린 후 학습을 중단할지를 지정
    - `min_delta = 0.001` 개선으로 간주할 최소 변화량 , 기본값은 0.0

` wandb_logger = WandbLogger(project="ImageNet")` 는 PyTorch Lightning에서 Weights & Biases(W&B)를 사용하여 학습 과정을 로깅하는 설정을 정의하는 코드
    - `WandbLogger(project="ImageNet")` 모델 학습 중 발생하는 다양한 메트릭과 정보를 실시간으로 시각화 하고 클라우드에 저장하여 쉽게 모니터링하고 분석할 수 있도록 한다.  
    - 프로젝트 관리: project 인자로 지정한 이름으로 프로젝트를 생성하고, 해당 프로젝트 아래에 모든 실험을 로깅
    - 실시간 시각화: 학습 중 손실, 정확도 등 다양한 메트릭을 실시간으로 확인
    - 실험 기록 관리: 여러 실험 결과를 클라우드에 저장하고 쉽게 비교할 수 있으며, W&B 대시보드를 통해 접근 할 수 있다
    - 하이퍼파라미터 로깅: 모델 학습에 사용된 하이퍼파라미터를 자동으로 기록하고 관리
    - W&B 계정에 로그인한 상태에서 대시보드를 통해 학습 메트릭과 하이퍼파라미터를 실시간으로 모니터링하고, 이후에도 기록된 데이터를 분석할 수 있습니다.
    - ` WandbLogger(project="ImageNet",name="ResNet_Training" log_model=True)` 이런식으로 프로젝트 내에 개별 이름을 정하거나 가중치도 W&B에 저장할 수 있음

```python
if mode == 'train':
        trainer = L.Trainer(
            accelerator=device,
            devices=gpus,
            max_epochs=epoch,
            precision=precision,
            logger=wandb_logger,
            callbacks=[checkpoint_callback, early_stopping],
        )
        trainer.fit(model, ImageNetDataModule(data, batch))
        trainer.test(model, ImageNetDataModule(data, batch))
    else:
        trainer = L.Trainer(
            accelerator=device,
            devices=gpus,
            precision=precision
        )
        model = ClassficationModel.load_from_checkpoint(ckpt, model=create_model(classification_model))
        pred_cls, img = trainer.predict(model, ImageNetDataModule(data, mode='predict'))[0]
        txt_path = '../dataset/folder_num_class_map.txt'
        classes_map = pd.read_table(txt_path, header=None, sep=' ')
        classes_map.columns = ['folder', 'number', 'classes']
        
        pred_label = classes_map['classes'][pred_cls.item()]
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        img = cv2.resize(img, (800, 600))
        cv2.putText(
            img,
            f'Predicted class: "{pred_cls[0]}", Predicted label: "{pred_label}"',
            (50, 50),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.8,
            (0, 0, 0),
            2
        )
        cv2.imshow('Predicted output', img)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

```
`mode == train`일 경우  

```python
 trainer = L.Trainer(
            accelerator=device,
            devices=gpus,
            max_epochs=epoch,
            precision=precision,
            logger=wandb_logger,
            callbacks=[checkpoint_callback, early_stopping],
        )
```
- `L.Trainer`는 `import lightning as L`에서 가져온 것
    - Trainer를 생성하여 모델 학습을 관리하고 제어하는 객체
    - 모델 학습 루프를 자동으로 처리
    - CPU/GPU 선택, 에포크 수, 콜백, 로깅 등 다양한 설정을 제공
    - `accelerator=device` Trainer에서 학습에 사용할 장치를 설정
        - `device` 변수에 따라 학습을 cpu, gpu, tpu 에서 진행(*def main의 인자로 device 받음*)
    - `devices=gpus` 지정한 accelerator 장치 유형에서 사용할 장치의 개수 또는 ID를 지정
        - 예를 들어, accelerator="gpu"와 함께 devices=2를 설정하면, 사용 가능한 GPU 중 2개를 사용합니다. GPU ID를 지정할 수도 있습니다(예: devices=[0, 1]).
        - CPU일 때는 devices=1로 기본 설정됩니다.
    - `max_epochs =epoch` 학습할 에포크 수를 지정
    - `precision=precision` 정밀도를 설정, 16 또는 32로 설정 가능하며, 16비틑 메모리 절약과 학습 속도 개선에 유리
    - `logger= wandb_logger` 로깅을 위한 객체를 지정, 여기서는 WandbLogger를 사용해 학습 메트릭을 기록 
    - `callbacks= [checkpoint_callback, early_stopping]` 학습 중 특정 시점에서 동작을 정의하는 콜백 리스트 지정합니다.

```python
        trainer.fit(model, ImageNetDataModule(data, batch))
        trainer.test(model, ImageNetDataModule(data, batch))
```
- `trainer.fit()` PyTorch Lightning에서 모델 학습을 시작하는 함수
    - 학습 데이터와 검증 데이터를 입력받아 모델의 학습을 진행
    - `model` 학습할 LightningModue 인스턴스를 지정, 모델 정의오 `forward`, `trainig_step`, `validation_step`등이 포함되어 있어야 함
        - `model`은 `./` 의 `model = ClassficationModel(create_model(classification_model))`에서 정의 됨
    - `train_dataloader` 학습 데이터 로더를 지정, 이 데이터로 모델이 학습
        - `src.dataset` 에서 정의
    - `val_dataloader` 검증용 데이터 로더를 지정, 선택
        - `src.dataset` 에서 정의

- `trainer.test()`는 Pytorch Lightning에서 학습이 완료된 모델을 테스트 데이터로 평가하기 위해 사용하는 메서드
    - 주로 모델의 최종 성능을 검증하거나, 학습이 완료된 모델이 새로운 데이터에 대해 얼마나 잘 작동하는지 평가할 때 사용
    - `trainer.fit`와 주요 파라미터가 같다
    - `ckpt_path =checkpoint_path` 를 하여 저장된 가중치를 불러와 테스트 할 수 있다(*trainer.fit에서도 사용가능함*)

`if mode != 'train':` 인 경우

```python
 trainer = L.Trainer(
            accelerator=device,
            devices=gpus,
            precision=precision
        )
        model = ClassficationModel.load_from_checkpoint(ckpt, model=create_model(classification_model))
        pred_cls, img = trainer.predict(model, ImageNetDataModule(data, mode='predict'))[0]
        txt_path = '../dataset/folder_num_class_map.txt'
        classes_map = pd.read_table(txt_path, header=None, sep=' ')
        classes_map.columns = ['folder', 'number', 'classes']
        
        pred_label = classes_map['classes'][pred_cls.item()]
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        img = cv2.resize(img, (800, 600))
        cv2.putText(
            img,
            f'Predicted class: "{pred_cls[0]}", Predicted label: "{pred_label}"',
            (50, 50),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.8,
            (0, 0, 0),
            2
        )
        cv2.imshow('Predicted output', img)
        cv2.waitKey(0)
        cv2.destroyAllWindows()
```


