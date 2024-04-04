---
layout: post
title: "dataset of object-detection"
date: 2024-04-03
categories: hnvlab
---
# src/dataset
> 출처: https://github.com/hnvlab-syu/pytorch-course/tree/master/pytorch-course/object-detection/global-wheat-detection
    

# Abstract Syntax Trees 

python의 추상 구문트리를 사용해 문자열을 평가하며 Python의 데이터 타입(리스트, 딕셔너리, 숫자, 문자열 등)으로 구성된 표현이라면 그에 해당하는 Python 객체로 변환한다.  

eval 함수와 달리 literal_eval은 코드를 실행하지 않기 때문에 악의적인 코드 실행으로부터 안전(보안적 측면이 좋다)  
  
    ''' python

    # 문자열 형태의 리스트
    string_list = "[1, 2, 3, 4, 5]"

    # 문자열을 리스트 객체로 변환
    converted_list = literal_eval(string_list)

    print(converted_list)  # 출력: [1, 2, 3, 4, 5]
    '''

# Typing

python 코드의 정적 타입 힌트를 지원, 코드의 명확성과 가독성을 향상시키고, 개발자가 타입 관련 오류를 더 쉽게 발견하고 예방할 수 있게 돕는다

    '''python

    from typing import List, Optional

    def greet_all(names: List[str]) -> None:  # List에 타입정보를 힌트로 넣는다
        for name in names:
            print(f"Hello, {name}!")

    def get_first_element(elements: List[int]) -> Optional[int]:  # List와 Optional에 타입정보를 힌트로 넣는다
        return elements[0] if elements else None
    '''

# Python Imageing Libray

이미지 파일을 열고, 조작하고, 저장하는 기능을 제공  
다양한 이미지 형식의 처리가 가능하며, 이미지 필터링, 이미지 변환, 이미지 드로잉 등의 기능을 제공  

    '''python
    from PIL import Image

    # 이미지 열기
    image = Image.open("example.jpg")

    # 이미지 크기 조정
    resized_image = image.resize((300, 300))

    # 이미지 회전
    rotated_image = image.rotate(90)

    # 이미지 저장
    rotated_image.save("rotated_example.jpg")
    '''

# from torch.utils.data import Dataset

Dataset클래스를 상속받아 사용자 정의 데이터셋을 쉽게 생성할 수 있으며, 데이터 로딩과 배치처리를 위한  **DataLoader**와 함께 사용   

__init__, __len__, __getitem__ 메서드를 오버라이딩(재정의) 해야 한다. 이를 통해 다양한 종류의 데이터를 머신러닝 모델 학습에 적합한 형태로 쉽게 불러오고, 전처리하며, 배치 단위로 나눌 수 있다.  

# __init__ 메서드  
- 데이터셋 객체가 생성될 때 초기화를 위해 호출됩니다. 여기서는 데이터셋에 필요한 파일 경로, 데이터 전처리 방법 등과 같은 초기 설정을 수행합니다.

#  __len__ 메서드
- 데이터셋의 전체 크기를 반환합니다. 즉, 데이터셋에 포함된 샘플의 수를 나타내며, Python의 내장 함수 len()에 의해 호출됩니다.

# __getitem__ 메서드
- 주어진 인덱스에 해당하는 샘플을 데이터셋에서 불러오고, 필요한 전처리를 적용한 후 반환합니다. 이 메서드는 데이터 로더(DataLoader)에 의해 반복적으로 호출되어, 모델 학습 또는 평가를 위한 데이터 배치를 구성하는 데 사용됩니다. 

__*Dataset을 상속받지 않으면 DataLoader에 직접 전달될 수 없으며, PyTorch의 자동 배치 처리, 샘플 셔플링, 병렬 데이터 로딩 등의 기능을 사용할 수 없습니다.(호환성의 문제)*__   

<pre>
import torch
from torch.utils.data import Dataset

class CustomDataset(Dataset):
    def __init__(self, data, transform=None):
        self.data = data
        self.transform = transform

    def __len__(self):
        return len(self.data)

    def __getitem__(self, idx):
        sample = self.data[idx]
        if self.transform:
            sample = self.transform(sample)
        return sample

# 예시 데이터와 데이터셋 객체 생성
data = list(range(1, 101))  # 1부터 100까지의 숫자 리스트
dataset = CustomDataset(data)

# 데이터셋의 크기와 첫 번째 샘플 출력
print(f"Dataset size: {len(dataset)}")
print(f"First sample: {dataset[0]}")

</pre>

# Pandas
- pd.read_csv():  csv 파일을 읽어서  DataFrame 객체로 변환하는 기능 제공, 각 행은 데이터 레코드, 열은 레코드의 속성을 나타낸다
    - 레코드: 관련된 데이터 항목들의 모음
- groupby(by='열'): column의 열의 값에 따라 데이터를 그룹화 

*ex)*

| image_id | object_type | bbox_x| bbox_y|
|--------|--------|--------|--------|
| 1 | dog | 30 | 50 |
| 1 | cat | 45 | 60 |
| 2 | bird | 10 | 20 |
| 2 | dog | 20 | 30 |
| 3 | cat | 5 | 10 |

'''python

import pandas as pd


data = {
    'image_id': [1, 1, 2],
    'object_type': ['dog', 'cat', 'bird','dog', 'cat'],
    'bbox_x': [30, 45, 10, 20, 5],
    'bbox_y': [50, 60, 20, 30, 10]
}  # 데이터셋 생성

df = pd.DataFrame(data)

grouped = df.groupby(by='image_id')  # 'image_id'로 그룹화

for image_id, group in grouped:  # 그룹화된 결과 확인하기
    print(f"Image ID: {image_id}")
    print(group, "\n")
'''
<pre>
출력

Image ID: 1
   image_id object_type  bbox_x  bbox_y
0         1         dog      30      50
1         1         cat      45      60 

Image ID: 2
   image_id object_type  bbox_x  bbox_y
2         2        bird      10      20
3         2         dog      20      30 

Image ID: 3
   image_id object_type  bbox_x  bbox_y
4         3         cat       5      10 
</pre>

#  boxes = np.array([literal_eval(box) for box in self.grouped_dict[image_id]['bbox']])
- 입력된 image_id와 bbox의 값 ( csv 파일을 보면 리스트 형태로 표현했음을 알 수 있다, 그러나 csv에서 왔으므로 타입은 문자열) 그래서 literal_eval()을 사용하여 리스트로 만들어줌
    - np.array()는 반복 가능한 객체를 인수로 받는다.

```python
# 가정한 bbox 리스트 (여러 객체의 bbox 정보)
boxes = np.array([
    [834.0, 222.0, 56.0, 36.0],
    [226.0, 548.0, 130.0, 58.0],
    [377.0, 504.0, 74.0, 160.0],
    [834.0, 95.0, 109.0, 107.0],
    [26.0, 144.0, 124.0, 117.0],
    [569.0, 382.0, 119.0, 111.0]
])
# [x_min, y_min, width, height]
# boxes[:, 2]에 해당하는 값 확인
boxes[:, 2]

# Result
# array([ 56., 130.,  74., 109., 124., 119.])
labels = [1] * len(boxes)
# labels = [1,1,1,1,1,1]
# 클래스 레이블이 모두 동일하기 때문에, 모델의 핵심 작업은 이미지 내에서 해당 객체들의 위치를 정확히 식별
```

<pre>
train.csv

image_id	width	height	bbox	source
b6ab77fd7	1024	1024	[834.0, 222.0, 56.0, 36.0]	usask_1
b6ab77fd7	1024	1024	[226.0, 548.0, 130.0, 58.0]	usask_1
b6ab77fd7	1024	1024	[377.0, 504.0, 74.0, 160.0]	usask_1
b6ab77fd7	1024	1024	[834.0, 95.0, 109.0, 107.0]	usask_1
b6ab77fd7	1024	1024	[26.0, 144.0, 124.0, 117.0]	usask_1
b6ab77fd7	1024	1024	[569.0, 382.0, 119.0, 111.0]	usask_1

annotation{
"id": int, "image_id": int, "category_id": int, "segmentation": RLE or [polygon], "area": float, "bbox": [x,y,width,height], "iscrowd": 0 or 1,
}
</pre>

<pre>
In [2]: np.array('[834.0, 222.0, 56.0, 36.0]')
Out[2]: array('[834.0, 222.0, 56.0, 36.0]', dtype='<U26')
</pre>

# DataLoader
- 데이터셋에서 데이터를 배치 단위로 자동으로 로딩하고 생성해주는 역할을 한다

'''python
def collate_fn(batch: Tensor) -> Tuple:
    return tuple(zip(*batch))
'''

- dataset: 로드할 데이터셋. PyTorch의 Dataset 객체여야 합니다.
- batch_size: 배치 크기. 데이터셋에서 한 번에 로드할 샘플의 수입니다.
- shuffle: 데이터를 섞을지 여부를 나타내는 불리언 값. 학습 데이터셋에 대해서는 주로 True로 설정하여 데이터를 무작위로 섞습니다.
- num_workers: 데이터 로딩을 위해 사용할 서브 프로세스의 수. 멀티 프로세싱을 통해 데이터 로딩 속도를 향상시킬 수 있습니다.
- collate_fn: 배치 데이터를 어떻게 결합할지 정의하는 함수. 복잡한 데이터 구조나 사용자 정의 데이터 처리가 필요할 때 지정할 수 있습니다.



# 배치 
![batch](/assets/hnvimg/batch.png)  
- 딥러닝에서 모델이 전체 학습 데이터를 한 번씩 본 것을 '에폭을 돌았다'라고 표현한다.  
- 모델은 가중치를 한 번 업데이트하기 위해 한 개 이상의 훈련 데이터 묶음을 사용하는데, 이것을 배치라고 한다.
- 이 묶음의 사이즈가 바로 배치 사이즈(batch size) 

# 배치와 에폭. 여러 개의 배치가 모여 1 에폭을 형성한다.
 
**배치 크기와 모델 훈련 시간의 관계**
100개의 훈련 데이터를 가지고 80에폭 동안 훈련시킨다고 가정해보자.

1. 배치 크기=1이면, 모델은 1에폭 당 100번 훈련(가중치 업데이트), 총 8000번 훈련
2. 배치 크기=10이면, 모델은 1에폭 당 10번 훈련, 총 800번 훈련
3. 배치 크기=100이면, 모델은 1에폭 당 1번 훈련, 총 80번 훈련

> 출처: https://otugi.tistory.com/350