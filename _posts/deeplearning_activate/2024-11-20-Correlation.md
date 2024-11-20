---
title: correlation
date: 2024-11-20
category: deeplearning
layout: post
---

# 상관관계
두 변수 간의 연관성을 나타내는 통계적 개념  
우리는 좌표와 0과 1 의 관계를 살펴 볼 것임  


```python
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
from dataload import load_data

import numpy as np  # 랜덤 샘플링에 사용

# 데이터 로드
train_x, train_y, test_x, test_y, val_x, val_y = load_data('../data/train', '../data/test', '../data/val')

# 훈련 데이터를 DataFrame으로 변환
train_df = pd.DataFrame(val_x)
train_df['label'] = val_y  # 레이블 추가

# 랜덤으로 50개 샘플 선택
sampled_df = train_df.sample(n=50, random_state=42)  # random_state로 재현성 유지

# 상관계수 계산
correlation_matrix = sampled_df.corr()

# 상관계수 히트맵 시각화
plt.figure(figsize=(12, 8))
sns.heatmap(correlation_matrix, annot=True, fmt=".2f", cmap="coolwarm", cbar=True)
plt.title("Correlation Matrix of Randomly Sampled Features and Label")
plt.savefig("correlation_matrix_sampled_heatmap.png", dpi=300, bbox_inches="tight")

# 레이블과 각 변수 간의 상관계수 추출
label_correlation = correlation_matrix['label'].sort_values(ascending=False)
print("Correlation of features with label (sampled data):")
print(label_correlation)
```


`correlation_matrix = combined_data.corr()`는 `pandas`에서 제공하는 메서드  
- 데이터프레임의 각 열(컬럼) 간의 **상관관계(coefficient of correlation)**를 계산합니다.
-  이 상관계수는 두 변수 간의 선형 관계를 나타내며, 값은 -1에서 1 사이입니다.

```
1: 완벽한 양의 상관관계 (하나가 증가하면 다른 하나도 증가)
-1: 완벽한 음의 상관관계 (하나가 증가하면 다른 하나는 감소)
0: 상관관계 없음 (변수 간에 선형 관계가 없음)
```

### **중요한 점**
`combined_data.corr()`는 기본적으로 숫자형 데이터만 사용합니다.  
따라서, CSV 파일의 이름이나 좌표(특정 텍스트 또는 범주형 데이터)가 포함된 경우, 이를 수치 데이터로 변환하거나 그룹핑 작업을 수행해야 상관관계를 분석할 수 있습니다.


실패
--
자원을 엄청 잡아먹더니  
상관관계 분석이 안된다...   
