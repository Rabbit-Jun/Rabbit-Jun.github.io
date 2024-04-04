---
layout: post
title: "train of object-detection"
date: 2024-04-03
categories: hnvlab
---

# argparse
- 파이썬 스크립트에 대한 명령줄 인터페이스를 숩게 구축할 수 있게해주는 라이브러리
- 사용자가 스크립트를 실행할 때 인자를 통해 다양한 옵션을 지정할 수 있게 해준다  


```python
import argparse

# ArgumentParser 객체 생성
parser = argparse.ArgumentParser(description='Example script to demonstrate argparse usage.')

# 인자 추가
parser.add_argument('--input', type=str, help='Input file path')
parser.add_argument('--output', type=str, help='Output file path')
parser.add_argument('--threshold', type=float, default=0.5, help='Threshold for processing')

# 인자 파싱, 스크립트에 전달된 인자들을 파싱하여 사용할 수 있는 형태로 만든다
args = parser.parse_args()

# 인자 사용
print(f"Input file: {args.input}")
print(f"Output file: {args.output}")
print(f"Processing threshold: {args.threshold}")

```

# shutil
- 파일과 파일 컬렉션에 대한 여러 고수준 연산(ex. 복사, 삭제, 이동)을 제공하는 라이브러리

# matplotlib
- matplotlib.pyplot: 데이터를 그래픽이나 차트로 시각화하는 데 사용됩니다.
- matplotlib.patches: 그래픽과 차트에 도형(예: 사각형, 원)을 그릴 때 사용됩니다.
- matplotlib.patheffects: 도형이나 텍스트에 다양한 시각적 효과를 추가할 때 사용됩니다.

# Pytorch 및 Torchvision
- torch.nn: 신경망을 구축하기 위한 기본 빌딩 블록을 제공합니다.
- torch.optim: 최적화 알고리즘(예: SGD, Adam)을 제공합니다.
- torch.utils.data.DataLoader: 데이터 로딩을 위한 반복 가능한(iterable) 객체를 생성합니다. 배치 처리, 샘플링, 데이터 셔플링과 같은 기능을 제공합니다.
- torchvision.transforms: 이미지에 대한 전처리와 증강(augmentation)을 위한 변환(transform) 함수들을 제공합니다.
- torchvision.models.detection.fasterrcnn_resnet50_fpn: 사전 훈련된 Faster R-CNN 모델을 불러오는 함수입니다. 이 모델은 객체 탐지를 위해 널리 사용됩니다.

# shutil.rmtree(save_dir)
- Python의 shutil (shell utilities) 모듈을 사용하여 지정된 경로(save_dir)에 있는 디렉토리를 재귀적으로 삭제하는 명령
    -  해당 경로에 위치한 디렉토리와 그 디렉토리 내부의 모든 파일 및 하위 디렉토리를 완전히 삭제한다는 의미입니다.

# random.choices(sequence, k=n_images)
- 주어진 시퀀스에서 중복을 허용하여 k개의 요소를 무작위로 선택한다.

# plt.gca()
- Get Current Axes"의 약자로, 현재 활성화된 축(axes) 객체를 가져온다

# image = image.numpy().transpose(1, 2, 0) 
- PyTorch에서 이미지 텐서는 일반적으로 (채널, 높이, 너비) 형식(C, H, W)으로 저장
- matplotlib 등의 일부 다른 라이브러리나 이미지 처리 라이브러리는 이미지 데이터를 (높이, 너비, 채널) 형식(H, W, C)으로 사용

```python
rect = patches.Rectangle(
    (x1, y1), w, h, linewidth=1, edgecolor='green', facecolor='none' 
)  # 사각형 모양의 패치를 생성합니다. 여기서 (x1, y1)은 사각형의 왼쪽 상단 모서리의 좌표를 나타내며, w와 h는 각각 사각형의 너비와 높이
  # linewidth=1: 사각형의 테두리 두께를 지정
  # edgecolor='green': 사각형의 테두리 색상을 지정
  # facecolor='none': 사각형 내부의 색을 지정
ax.add_patch(rect)  # 생성된 rect 사각형 패치를 현재의 축(ax)에 추가
```

#  plt.clf()  
- 현재 플롯 클리어