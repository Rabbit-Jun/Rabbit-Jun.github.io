---
title: prepare_data
date: 2024-11-04
category: deeplearning
layout: post
---
# 데이터 준비하기
나같은 경우에는 교수님이 추천해주신 ai허브에서 크로스핏 데이터를 다운 받았다.  
근데 폴더 안에 폴더안에 폴더형태로 되어있어 이걸 먼저 정리해야 내가 뭔갈 할 수 있을거라 판단!!  
일단 폴더의 내용을 보기 위해 `ls -R`을 눌렀는데....  

끝이 안보이게 한없이 내려가는 터미널... 

```
./팔자세오류/초급/CB08/2/camera2/video:
annotation.json

./팔자세오류/초급/CB08/2/camera3:
local_keypoints  video

.
.
.

./팔자세오류/초급/CB08/2/camera7:
local_keypoints  video
```
나는 주어진 keypoints를 이용할거니 내게 필요한것은 local_keypoints가 있는 csv파일 뿐 하여 이 파일을 제외한 나머지는 버리기로 결정!!  
옮기기전에 `find . -type d -name "local_keypoints" | wc -l`을 이용해서 파일들의 개수를 한번 검색해보니 **2952**개 드드  

그럼 이제 파일을 내가 쓸려는 폴더에 복사를 한번 해보자(*나는 c드라이브에 넣을 용량이 없어서 d드라이브에 넣었기에 파일 시스템이 다르다, 즉 복사를 해서 옮겨야 한다*)

바로 `find . -type d -name "local_keypoints" -exec cp -r {} "path"\;`을 해줘 내가 사용할 프로젝트의 디렉터리로 복사!  

음... 그런데 복사된 상태가 뭔가 이상하다 싶어 곰곰히 생각을 해보니  
정상과 비정상을 따로 구분해줘야 했는데 그것도 하지 않았고 무엇보다 아까 검색했을때는 2952개였던 폴더가 내 프로젝트에는 local_keypoints라는 폴더가 하나 밖에 없다???  

어찌된걸까요?  
정답은 바로 덮어쓰기가 되었다는 것!ㅋㅋㅌㅌㅋㅋ ㅠ.ㅠ  

해서 정상과 비정상을 나누고 혹시 몰라 `find ./'path' -type d -name 'name' |wc -l`을 하여 개수도 세보고 `find ./'path' -type d -name 'name' -exec ls -R {} \;`를 해보니 내가 사용할려는 csv 파일도 이름이 중복이 되네ㅠ.ㅜ  
(*궁금한 분들은 아래에 내 데이터의 구조를 간략히 보여주겠다.*)  

하여 나는 경로에서 4번째 값과 motion* 파일이름을 합하여 프로젝트의 데이터 폴더에 복사하기로 했다.  
```zsh
#!/bin/zsh

# 데이터 폴더와 복사 폴더 배열 정의
data_folder=("가슴및고관절오류" "고관절이동오류" "정상" "팔자세오류")
cp_folder=("chest_and_hip_joint_errors" "hip_joint_movement_errors" "normal" "arm_posture_errors")

# 배열 인덱스를 사용하여 각 폴더 처리
for i in {1..${#data_folder[@]}}; do
    # 각 데이터 폴더에서 파일 찾기 및 복사
    find ./${data_folder[i]} -type f -name "Motion*.csv" | while read filepath; do
        # 경로 중 4번째 요소 추출
        dirname=$(echo "$filepath" | cut -d '/' -f 4)
        
        # 파일명 추출 및 새 파일 이름 생성
        filename=$(basename "$filepath")
        new_filename="${dirname}_${filename}"
        
        # 파일을 지정된 복사 폴더로 복사
        cp "$filepath" "$dm/projects/data/${cp_folder[i]}/$new_filename"
    done
done

```
**zsh는 배열 인덱싱이 1부터 시작한다**  
코드를 보면 알겠지만 비정상에 해당하는게 3가지나 된다.  
```
(base) ➜  data find . -type f -name "*.csv" | wc -l
2224
(base) ➜  data find ./normal -type f -name "*.csv" | wc -l
1224
(base) ➜  data find ./hip_joint_movement_errors -type f -name "*.csv" | wc -l
352
(base) ➜  data find ./arm_posture_errors -type f -name "*.csv" | wc -l
336
(base) ➜  data find ./chest_and_hip_joint_errors -type f -name "*.csv" | wc -l
312
```
normal이 비정상보다 더 개수가 많다.  
어찌 처리해야 할지 고민이다. 
 
```python
(base) ➜  data find ./val/normal -type f -name "*.csv" | wc -l
112

(base) ➜  data find ./val/hip_joint_movement_errors -type f -name "*.csv" | wc -l
120
(base) ➜  data find ./val/arm_posture_errors -type f -name "*.csv" | wc -l
80
(base) ➜  data find ./val/chest_and_hip_joint_errors -type f -name "*.csv" | wc -l
96
(base) ➜  data find ./val -type f -name "*.csv" | wc -l
408
```


```
(base) ➜  data ls
train  val
```
작업 진행도 20%

.  
.  
.  

*처음 만난 나의 안타까운 데이터구조*
```
./가슴및고관절오류/고급/CA01/1/camera1/local_keypoints:
Motion2-2.csv
./가슴및고관절오류/고급/CA01/1/camera2/local_keypoints:
Motion2-3.csv
./가슴및고관절오류/고급/CA01/1/camera3/local_keypoints:
Motion2-4.csv
./가슴및고관절오류/고급/CA01/1/camera4/local_keypoints:
Motion2-5.csv
./가슴및고관절오류/고급/CA01/1/camera5/local_keypoints:
Motion2-6.csv
./가슴및고관절오류/고급/CA01/1/camera6/local_keypoints:
Motion2-7.csv
./가슴및고관절오류/고급/CA01/1/camera7/local_keypoints:
Motion2-8.csv
./가슴및고관절오류/고급/CA01/2/camera0/local_keypoints:
Motion2-1.csv
./가슴및고관절오류/고급/CA01/2/camera1/local_keypoints:
Motion2-2.csv
```