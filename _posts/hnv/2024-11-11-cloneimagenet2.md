---
title: Readme2
date: 2024-11-11
categories: hnv
layout: post
---
# Readme를 읽어보자2

### 훈련 
- `python train.py -m your_device -dc "your_image_path -g "0" `이렇게 인자를 전달
(*이게 argparse인듯 하다*)
- model(필수): 사용할 모델 선택 (vgg or resnet or efficientnet)
- device(선택): 훈련에 사용할 디바이스 선택 (cpu or cuda)
- 나머지 인자는 코드에서 확인

### 예측
- `python predict.py -m your_device -dc "your_image_path -g "0" --image_path "your_image_path`

- ip, image_path(필수): 예측할 이미지 파일 선택
- m, model(필수): 사용할 모델 선택 (vgg or resnet or efficientnet)
- dc, device(선택): 훈련에 사용할 디바이스 선택 (cpu or gpu)
- g, gpus(선택): 훈련에 사용할 gpu개수 선택
- 나머지 인자는 코드에서 확인