---
layout: post
title: "one_epoch in model of object-detection"
date: 2024-04-04
categories: hnv
---
```python
    size = len(dataloader.dataset)
    model.train()
    for batch, (images, targets, _) in enumerate(dataloader):  
        # dataloader를 인덱스와 값으로 나눠 받음, dataloader는 dataset을 상속받으면 자동으로 데이터를 받아서 미니배치를 자동으로 로딩하고 선택적으로 데이터를 섞서어 네트워크에 공급
        images = [image.to(device) for image in images]
        targets = [{k: v.to(device) for k, v in t.items()} for t in targets]

        loss_dict = model(images, targets)
        loss = sum(loss for loss in loss_dict.values())

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        if batch % 10 == 0:
            current = batch * len(images)
            message = 'total loss: {:>4f}, cls loss: {:>4f}, box loss: {:>4f}, obj loss: {:>4f}, rpn loss: {:>4f}  [{:>5d}/{:>5d}]'
            message = message.format(
                loss,
                loss_dict['loss_classifier'],
                loss_dict['loss_box_reg'],
                loss_dict['loss_objectness'],
                loss_dict['loss_rpn_box_reg'],
                current,
                size
            )
            print(message)
```
# message.format
- total loss: 모든 손실 값의 합계입니다.
- cls loss (loss_classifier): 분류 손실, 즉 모델이 객체의 종류를 얼마나 잘 분류하는지에 대한 손실입니다.
- box loss (loss_box_reg): 바운딩 박스 회귀 손실, 즉 모델이 객체의 위치와 크기를 얼마나 정확하게 예측하는지에 대한 손실입니다.
- obj loss (loss_objectness): 객체 존재 여부 손실, 즉 모델이 특정 위치에 객체가 존재하는지 여부를 얼마나 잘 판단하는지에 대한 손실입니다.
- rpn loss (loss_rpn_box_reg): Region Proposal Network (RPN)의 바운딩 박스 회귀 손실, 즉 RPN이 객체 후보 영역의 위치를 얼마나 정확하게 예측하는지에 대한 손실입니다.

# indices = random.choices(range(len(dataset)), k=n_images)
- 중복을 허용하여 랜덤으로 데이터셋에서 인덱스 선택

