---
title: model
date: 2024-06-27
categories: hnv
layout: objectdetection
---

torchvision.models:  
https://github.com/pytorch/vision/tree/main/torchvision/models  

# torchvision.detection
- torchvisoin.detection은 Pytorch의 컴퓨터 비전 관련 유틸리티를 제공하는 패키지의 하위 모듈로, 주로 객체 탐지와 관련된 기능들을 제공

# torchvision.detection.rpn
- Resion Proposal Network
- 입력 이미지에서 객체가 있을 가능성이 높은 영역 (Region of interest)을 제안하는 역할
- 이를 통해 객체 탐지 모델이 전체 이미지에서 객체를 일일이 찾는 대신, 제안된 후보 영역들에 집중하여 효율적으로 탐지 작업을 수행할 수 있다

# Backbone
- 특징 추출을 담당하는 기본 신경망을 의미
    - 객체 탐지, 이미지 분할, 이미지 분류 등의 다양한 비전 모델에서 중요한 역할을 합니다.
    - 입력 이미지에서 의미 있는 특징 맵을 추출하여 후속처리 단계(객체의 경계 상자 예측, 등)에 사용
- 대표적으로 ResNet, VGG. EfficientNet, MobileNet 등이 있음
- ex)
```python
        self.backbone = efficientnet_b0(weights=EfficientNet_B0_Weights.DEFAULT).features
        self.backbone.out_channels = 1280  #   EfficientNet-B0의 마지막 특징 맵의 출력 채널 수는 1280


```python
import torch
from torchvision.models import efficientnet_b0, EfficientNet_B0_Weights

# EfficientNet-B0 모델 로드
model = efficientnet_b0(weights=EfficientNet_B0_Weights.DEFAULT)

# 모델 구조 출력 (필요시 주석 해제)
# print(model)

# 특징 맵의 출력 채널 수 확인
# 마지막 계층의 출력 채널 수는 모델의 특징 추출 부분의 마지막 Conv 층의 출력 채널 수와 동일합니다.
last_feature_layer = model.features[-1]
print(f"Last feature layer output channels: {last_feature_layer.out_channels}")
```

def_efficient_conf(): 에 last_channel 을 보면 알 수 있음
