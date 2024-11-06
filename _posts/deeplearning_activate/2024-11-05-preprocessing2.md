---
title: preprocessing_data2
date: 2024-11-04
categories: deeplearning
layout: post
---
### csv에 레이블을 넣어보자
각 csv에 해당하는 레이블은 디렉터리의 이름이다.  
즉, 디렉터리의 이름 값을 csv의 마지막 행에 넣어주면 되는 것!  
.  
.  
.  
이라고 생각을 했으나 생각해보니 많이 이상하다...   
csv가 약 300개정도로 이루어져 있고 그 행들이 다 합쳐 하나의 동작인데 csv에 label을 넣고 각 행에 nomal, error의 값을 넣는다는게 말이 안됨  
(*어떤 관절 포인트가 정상 또는 비정상이 아니라 관절 포인트가 다른 관절포인트와의 상호작용으로 알아내는것이니 하나의 행으로는 정상과 비정상을 알 수가 없음*)

그럼 어찌해야 하냐...
# csv의 경로를 이용하여 csv의 이름 바꾸자!
주의 깊게 본 사람은 알겠지만  
내 csv파일은
```
filename=['arm_posture_errors',  'chest_and_hip_joint_errors',  'hip_joint_movement_errors', 'normal']
```
의 이름의 디렉터리 안에 있다.  
그리고
```
['../data/train/arm_posture_errors/CA01_Motion2-1.csv', '../data/train/arm_posture_errors/CA01_Motion2-2.csv', '../data/train/arm_posture_errors/CA01_Motion2-3.csv', '../data/train/arm_posture_errors/CA01_Motion2-4.csv',
```
이러한 경로 안에 있다.  
즉, 경로에서 4번째 인자값과 5번째 인자값을 합하여 새로운 이름으로 만들고 4번째 인자값으로 레이블로 인식하게 분류기를 작성하면 되는 것!  
(*처음 데이터를 복사할 때 여기까지 생각할 수 있었으면 좋았을 텐데ㅠ.ㅜ*)  
**%후에 분류기에서 4번째와 5번째를 구별할 수 있게끔 특별한 기호같은걸 넣어주는 걸 잊지 말자**

```python
import os
import glob
import shutil


filename = ['arm_posture_errors', 'chest_and_hip_joint_errors', 'hip_joint_movement_errors', 'normal']
train_paths = [f'../data/train/{file}/*.csv' for file in filename]
train_data_path = '../data/train'
csv_files = []
for path in train_paths:
    csv_files.extend(glob.glob(path))

for file_path in csv_files:
    parts = file_path.split('/')
    label = parts[3]
    original_filename = parts[4]

    new_filename = f"{label}@{original_filename}"
    print(os.path.dirname(file_path))


    new_file_path = os.path.join(train_data_path, new_filename)

    shutil.move(file_path, new_file_path)
```
하고 같은 방식으로 val도 옮겨 준다  
