---
title: correlation2
date: 2024-11-20
category: deeplearning
layout: post
---

# GPU로 상관관계분석
```python
import torch
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

# 랜덤으로 10개 샘플 선택
sampled_df = train_df.sample(n=10, random_state=42)  # random_state로 재현성 유지

# 샘플 데이터를 GPU 텐서로 변환
sampled_tensor = torch.tensor(sampled_df.values, device='cuda', dtype=torch.float32)

# 각 열의 평균과 표준편차 계산
mean = sampled_tensor.mean(dim=0, keepdim=True)
std = sampled_tensor.std(dim=0, keepdim=True)

# 정규화 (Z-score)
normalized_data = (sampled_tensor - mean) / std

# 상관계수 계산
correlation_matrix = (normalized_data.T @ normalized_data) / (normalized_data.size(0) - 1)

# CPU로 다시 변환 및 Pandas DataFrame으로 변환
correlation_matrix_cpu = correlation_matrix.cpu().numpy()
correlation_df = pd.DataFrame(correlation_matrix_cpu, columns=sampled_df.columns, index=sampled_df.columns)

# 상관계수 히트맵 시각화
plt.figure(figsize=(12, 8))
sns.heatmap(correlation_df, annot=True, fmt=".2f", cmap="coolwarm", cbar=True)
plt.title("Correlation Matrix of Randomly Sampled Features and Label (GPU Accelerated)")
plt.savefig("correlation_matrix_sampled_gpu_heatmap.png", dpi=300, bbox_inches="tight")

# 레이블과 각 변수 간의 상관계수 추출
label_correlation = correlation_df['label'].sort_values(ascending=False)
print("Correlation of features with label (GPU Accelerated):")
print(label_correlation)
```


실패
--
자원을 엄청 잡아먹더니  
상관관계 분석이 안된다...   
