---
title: preprocessing_data3
date: 2024-11-05
categories: deeplearning
layout: post
---
# 필요없는 특징 제거하기!
얼굴의 포인트에서 움직임을 알아 볼수만 있게 눈의 포인트값을 뺀 나머지는 제거해 버리자!
```python
# 데이터 경로와 제거할 열 목록 설정
train_data_path = '../data/train'
columns_to_drop = ['image_filename', 'Nose_x', 'Nose_y', 'LEar_x', 'LEar_y', 'REar_x', 'REar_y']

# 각 파일을 순회하며 처리
for file_name in os.listdir(train_data_path):
    if file_name.endswith('.csv'):
        file_path = os.path.join(train_data_path, file_name)

        # 파일 경로 출력
        print(f"Processing file: {file_path}")
        
        try:
            # CSV 파일 불러오기
            df = pd.read_csv(file_path)
            print(f"Columns before drop: {df.columns.tolist()}")  # 열 확인

            # 지정된 열 제거
            df = df.drop(columns=columns_to_drop, errors='ignore')
            print(f"Columns after drop: {df.columns.tolist()}")  # 열 확인

            # 동일한 경로에 저장
            df.to_csv(file_path, index=False)
            print(f"File saved successfully: {file_path}\n")

        except FileNotFoundError as e:
            print(f"FileNotFoundError: 파일을 찾을 수 없습니다 - {file_path}")
        except Exception as e:
            print(f"Error processing file {file_path}: {e}")
```
를 했는데 파일 하나가 문제가 생겼다.
```
Processing file: ../data/train/chest_and_hip_joint_errors@CI02_Motion2-5.csv
FileNotFoundError: 파일을 찾을 수 없습니다 - ../data/train/chest_and_hip_joint_errors@CI02_Motion2-5.csv
```
파일이 분명히 있는데도 찾을 수 없다길래 여러가지 손을 썼지만 이유를 알 수 없었다  
직접 봐보니 안에 특징은 제거가 되어 있다.  
다른건 다 되는데 이것만 안되니깐 환장할 노릇 ㅜ.ㅜ  
vscode를 껐다 키니 잘 됐다...  
아직도 이유를 모르겠다.  
```
Index(['LEye_x', 'LEye_y', 'REye_x', 'REye_y', 'LShoulder_x', 'LShoulder_y',
       'RShoulder_x', 'RShoulder_y', 'LElbow_x', 'LElbow_y', 'RElbow_x',
       'RElbow_y', 'LWrist_x', 'LWrist_y', 'RWrist_x', 'RWrist_y', 'LHip_x',
       'LHip_y', 'RHip_x', 'RHip_y', 'LKnee_x', 'LKnee_y', 'RKnee_x',
       'RKnee_y', 'LAnkle_x', 'LAnkle_y', 'RAnkle_x', 'RAnkle_y', 'Head_x',
       'Head_y', 'Neck_x', 'Neck_y', 'Hip_x', 'Hip_y', 'LBigToe_x',
       'LBigToe_y', 'RBigToe_x', 'RBigToe_y', 'LSmallToe_x', 'LSmallToe_y',
       'RSmallToe_x', 'RSmallToe_y', 'LHeel_x', 'LHeel_y', 'RHeel_x',
       'RHeel_y'],
      dtype='object')
```

### 이제 우리에게 남은 일을 중간 check!!
1. ~~레이블을 csv에 넣기~~ -> ~~csv파일명 변경하기~~
2. ~~필요 없는 특징 제거~~
3. 가까운 관절끼리의 각도 계산 값  

다음은 관절끼리의 각도를 계산 해 보도록 하자!
