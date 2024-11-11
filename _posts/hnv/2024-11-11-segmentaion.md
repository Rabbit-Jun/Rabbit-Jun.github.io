---
title: segmentaion1
date: 2024-11-11
categories: hnv
layout: post
---
# 계획을 세워보자
와 3줄 이상 있으면 뇌가 멈춰오는 나로서는 To-do list를 보는 것만으로도 힘이든다ㅠ.ㅜ  

### todo
1. 본인이 부여받은 Task directory에 데이터셋을 다운
2. 비어있는 파일 작성 및 코드 수정
3. lightning과 hydra-template만 작성하면 됨 (pytorch는 안해도 됨)

1번과 3번은 수행 및 이해 했기에 pass  
2번은 | https://github.com/hnvlab-syu/pytorch-course/tree/master/pytorch-course/semantic-segmentation/pascal 에서 말 그대로 비어있는 파일 *(ex pytorch-course/pytorch-course/semantic-segmentation/pascal/lightning
/main.py)* 을 채우면 된다는 의미  

<hr>

그럼 뭘 작성해야 하는지 lightning만 한번 보자  
```
/main.py
/README.md
/src/dataset.py
/src/model.py
/src/utils.py
```
hydra-template는 내가 진짜로 오늘 처음 봐서 뭐가 뭔지 하나도 모르겠으니 일단 pass  

### todo
4. data augmentation 1개 이상 적용 (e.g. rotation, flip, etc.)
5. 모델 두개 이상 불러와서 사용자가 선택해서 작동할 수 있도록 (pretrained 된걸 불러와야함)
6. lightning argparser 그대로 사용 (필요하다면 추가 해도됨)

4번은 그냥 기능 적용하면 될거 같고 

5번에 대해서 설명을 하자면 
### Lightning에서 여러 모델을 선택적으로 사용하는 방법
1. 여러 모델 정의: 필요한 만큼의 모델을 Lightning 모듈로 정의할 수 있습니다.

2. 사용자 선택을 위한 파라미터 추가: Trainer 또는 LightningModule 내에서 모델 선택을 위한 인자를 받아서 초기화 시 사용자가 선택할 수 있도록 합니다. 예를 들어, model_name 또는 model_type 인자를 통해 조건에 따라 모델을 결정할 수 있습니다.

3. Forward 메서드 수정: forward 메서드에서 model_name 값에 따라 다른 모델을 선택하여 입력을 처리하게 합니다.

4. 모델 선택 로직 작성: 사용자가 선택한 모델에 따라 조건을 걸어 해당 모델을 사용할 수 있도록 구현합니다.

를 하면 된다고 한다.  

### 6번 lightning argparser란?
- PyTorch Lightning에서 모델의 하이퍼파라미터, 학습 설정, 기타 옵션을 쉽게 설정하고 관리할 수 있도록 하는 인자 파싱 도구입니다.
- 이를 통해 다양한 설정을 명령줄 인자나 구성 파일을 통해 전달할 수 있습니다

# Lightning ArgParser 사용 방법
- ArgumentParser 정의: 필요한 하이퍼파라미터와 설정을 argparse.ArgumentParser로 정의합니다.

- LightningModule과 Trainer에 인자 전달: 정의된 인자를 LightningModule이나 Trainer에 전달하여 설정할 수 있습니다. 
- 이로 인해 모델 설정, 데이터 설정, 학습 설정 등을 명령줄 인자에서 쉽게 변경할 수 있습니다.
- 명령줄에서 실행: 스크립트를 실행할 때 명령줄 인자로 값을 전달할 수 있으며, 이를 통해 다양한 하이퍼파라미터 실험을 쉽게 반복할 수 있습니다.

# todo
9. wandb에 loss와 metric을 모두 나타내야함
10. 최종 결과 제출은 hnvlab-syu/pytorch-course github에 pull request
11. 본인이 사용한 모델 두개 중 하나 논문 발표 (류교수님의 특별 지시)



그럼 일단 imagenet에 있는 코드에서 
```
/README.md
/main.py
/src/dataset.py
/src/model.py
/src/utils.py
```
를 보고 클론 코딩 해보자
