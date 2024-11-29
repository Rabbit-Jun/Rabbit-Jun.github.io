---
title: Assignment1
date: 2024-11-27
category: aiclass
layout: post
---
# 과제
```
과제1 다양한 입력 데이터를 활용한 분류 모델 구현 및 성능 비교

과제 목표 : 머신러닝과 딥 러닝 접근법을 사용해 분류 모델 구현 및 성능 평가

과제 설명 : 

데이터 세트 : CIFAR-10, Flowers 를 이용

1) MLP으로 구현

2) CNN으로 구현

2-1) CNN의 완전 연결층을 Knn, SVM, Decision Tree, MLP로 각각 구현하여 MLP 결과와 각 모델의 정확도 측정과 성능 비교

2-2) 높은 정확도를 구현하기 위한 모델 개선

과제 포함 내용

구현 코드

데이터 세트 설명

각 모델의 정확도와 손실 그래프, 성능 비교와 해석

혼동행렬 그림과 결과 설명

고찰 : 구현 과정에서의 어려움, 모델 개선을 위한 변경 내용 등을 포함한 느낀 점

제출 방식 : word나 hwp로 작성하여 e-class에 제출
```
아... 너무 힘들다

일단 데이터셋은 온라인에서 다운받을 수 있게 교수님이 코드를 주신듯 하다 당장 실행해 봐야징...

아니네 링크를 주셨네   

The CIFAR-10 dataset  
|https://www.cs.toronto.edu/~kriz/cifar.html   

Flowers Dataset  
|https://www.kaggle.com/datasets/imsparsh/flowers-dataset  


일단 dataset이라는 폴더 만들어서 그 안에다가 다운 받아놓고  
분류를 해야 하니깐 일단 데이터가 뭔지 한번 봅시다  

Flower
휴 다행히 데이터는 그냥 사진만 있음 각 폴더명에 해당하는 꽃 사진이 있어서 따로 손될 건 없어보인다

The CIFAR-10 dataset  
아 다운 받았는데 원본이 아니라 뭘 해야 하는지...  

일단 교수님께서 올려주신 MLP랑 CNN을 보면서 공부를 좀 해보자  
내가 봤을땐 이거 보면서 따라하면 만들어 질듯 하다  

지금 추가 공지를 보니
```python
import tensorflow as tf
import matplotlib.pyplot as plt

class_names = [
    "Airplane", "Automobile", "Bird", "Cat", "Deer",
    "Dog", "Frog", "Horse", "Ship", "Truck"
]


(X_train, y_train), (X_test, y_test) = tf.keras.datasets.cifar10.load_data()

print("X_train.shape:", X_train.shape)
print("y_train.shape:", y_train.shape)
print("X_test.shape:", X_test.shape)
print("y_test.shape:", y_test.shape)

plt.figure(figsize=(10, 2))
for i in range(5):
    plt.subplot(1, 5, i + 1)
    plt.imshow(X_train[i])
    plt.title(class_names[y_train[i][0]])  # CIFAR-10 클래스 이름 표시
    plt.axis('off')
plt.show()
```
를 하면 cifar-10을 사용할 수 있나보다


 각 데이터 세트에 따라 진행할 코드는 총 5가지 입니다. 

  1) MLP, 2) CNN + KNN 3) CNN + SVM, 4) CNN + DT, 5) CNN + MLP

  5가지 모델에 대하여 학습 후 혼동행렬과 정확도 결과, 정확도와 손실 그래프를 작성하시면 되겠습니다.


  과제 2-1  

  * 2), 3), 4) 모델 Hint

  cnn_model의 Sequential()안에 Conv2D와 MaxPooling2D 등을 이용하여 특징 추출 부분 구현하고, Flatten 후 최종 출력에 해당하는 Dense 레이어 추가하여 작성한 후 

  cnn_model을 train데이터로 학습한 다음, train데이터를 이용해 predict 한 결과를 출력하고, 이후 KNN, SVM, DT 모델의 입력으로 활용하면 됩니다.

  KNN, SVM, DT는 epoch별로 학습과 손실 부분을 그래프로 표현하는 것을 배우지 않았으므로 CNN 부분만 정확도, 손실 그래프를 그리면 됩니다.

  5) CNN+MLP 

  강의자료에 있는 fashion dataset 코드를 활용하여 CNN+MLP를 구성하면 됩니다.

  

  과제 2-2  

  CNN+MLP 모델을 이용하여 레이어추가, 히든 노드 변경, dropout, data argumentation 등 수업 시간에 배운 여러 가지를 활용하여 정확도를 올리기 위한 모델 개선을 진행하면 됩니다.