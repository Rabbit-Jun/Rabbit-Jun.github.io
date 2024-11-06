---
title: preprocessing_data6
date: 2024-11-05
categories: deeplearning
layout: post
---
# ~~관절끼리의 각도계산을 해보자(3)~~ -> train을 train과 test로 나누자!
본래라면 관전끼리의 각도를 구하고 그 값을 특성에 넣을려고 했으나  
어찌 넣어야 할지도 막막하고 또 각도를 넣는다고 성능이 올라갈지도 의문이라 일단 지금 이대로 진행 후 학습을 마친 후 다시 각도계산으로 돌아오기로 결정!!  
```python
import os
import glob
import shutil
from sklearn.model_selection import train_test_split

train_dir = '../data/train'
train_output_dir = '../data/train_split/train'
test_output_dir = '../data/train_split/test'

os.makedirs(train_output_dir, exist_ok=True)
os.makedirs(test_output_dir, exist_ok=True)

normal_files = glob.glob(os.path.join(train_dir, 'normal*.csv'))
error_files = glob.glob(os.path.join(train_dir, '*errors*.csv'))


normal_train_files, normal_test_files = train_test_split(normal_files, test_size=0.2, random_state=42)
error_train_files, error_test_files = train_test_split(error_files, test_size=0.2, random_state=42)

train_files = normal_train_files + error_train_files
test_files =normal_test_files+error_test_files

for file in train_files:
    shutil.copy(file, train_output_dir)
for file in test_files:
    shutil.copy(file, test_output_dir)

print(f"Training files: {len(train_files)}")
print(f"Testing files: {len(test_files)}")
```
normal과 error의 전체적인 비율을 유지하면서 train과 test를 8:2로 분배~  
