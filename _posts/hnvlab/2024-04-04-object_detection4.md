---
layout: post
title: "model of object-detection"
date: 2024-04-04
categories: hnv
---

# CNN
![CNN](/assets/hnvimg/cnn.png)  
-  합성곱 연산을 통해 입력 이미지에서 유용한 정보를 필터링하고, 특징 맵(Feature Map)을 생성.  
    - 이 과정은 입력 이미지의 로컬 패턴, 예를 들어 모서리, 질감, 색상 등을 인식  

![CNN Formula](/assets/hnvimg/cnn_formula.png)  
- I는 입력 이미지를 나타냅니다.
- K는 필터(커널)을 나타냅니다.
- i,j는 출력 특징 맵의 위치를 나타냅니다.
- m,n은 필터 내의 위치를 나타냅니다.
<pre>
만약 필터의 크기가 F×F라면, m과 n의 범위는 0부터 F−1까지입니다. 예를 들어, 3×3 크기의 필터를 사용한다면, m과 n은 각각 0,1,2의 값을 갖게 됩니다
</pre>  

# Faster R-CNN (Regions with Convolutional Neural Network)  
![Faster R- CNN](/assets/hnvimg/Faster R-CNN.png)  
- 이미지 내에서 객체를 탐지하는 데 사용되는 딥러닝 기반의 알고리즘 중 하나
- **Region Proposal Network (RPN)**: RPN은 이미지에서 객체 후보 영역(Regions of Interest, RoIs)을 식별하는 역할
- **Fast R-CNN Detector**: 이 부분은 RPN에서 제안된 영역들을 사용하여 실제 객체 탐지를 수행
    - 각 영역에 대해 객체의 클래스를 분류하고, 바운딩 박스의 위치를 더욱 정밀하게 조정  

##### *바운딩 박스는 이미지 내 특정 객체를 둘러싸는 사각형입니다. 이는 객체의 위치를 나타내며, 일반적으로 (x, y) 좌표로 정의된 사각형의 왼쪽 상단 모서리와, 사각형의 너비와 높이로 표현*
### fasterrcnn_resnet50_fpn(num_classes=num_classes+1).to(device)
- ResNet-50 백본과 Feature Pyramid Network(FPN)를 사용하여 이미지 내의 객체를 탐지
    - ResNet-50 백본: ResNet-50은 깊은 신경망에서도 효과적으로 학습할 수 있도록 설계된 컨볼루션 신경망(CNN) 구조입니다.
        - 백본은 입력 이미지로부터 특징(feature)을 추출하는 역할을 수행하는 네트워크의 일부
    - FPN: 다양한 크기의 객체를 탐지하기 위한 효율적인 방법으로, 이미지에서 다양한 스케일의 특징을 추출할 수 있게 합니다
    - num_classes+1는 모델이 예측해야 하는 클래스의 수를 나타냅니다. 여기에 1을 더하는 이유는 배경 클래스도 포함되어야 하기 때문


