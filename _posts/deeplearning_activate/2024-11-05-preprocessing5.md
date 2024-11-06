---
title: preprocessing_data5
date: 2024-11-05
categories: deeplearning
layout: post
---
# 관절끼리의 각도 계산 값을 특징으로 넣어보자!(2)
```python
from matplotlib.animation import FuncAnimation

df = pd.read_csv(f'{train_data_path}/normal@CI09_Motion2-3 - 4of4.csv')

# 관절 연결 관계 설정
connections = [
    ('Head', 'Neck'), 
    ('Neck', 'LShoulder'), ('Neck', 'RShoulder'),
    ('LShoulder', 'LElbow'), ('RShoulder', 'RElbow'),
    ('LElbow', 'LWrist'), ('RElbow', 'RWrist'),
    ('Neck', 'Hip'),
    ('Hip', 'LKnee'), ('Hip', 'RKnee'),
    ('LKnee', 'LAnkle'), ('RKnee', 'RAnkle')
]

# 삼각형 연결 관계 설정
triangle_connections = [
    ('LBigToe', 'LSmallToe'), ('LSmallToe', 'LHeel'), ('LHeel', 'LBigToe'),
    ('RBigToe', 'RSmallToe'), ('RSmallToe', 'RHeel'), ('RHeel', 'RBigToe')
]

# 애니메이션 초기 설정
fig, ax = plt.subplots()
plt.title("Skeleton Animation")
ax.invert_yaxis()  # y축 뒤집기

# 프레임 초기화 함수
def init():
    ax.clear()
    plt.title("Skeleton Animation")
    ax.invert_yaxis()  # y축 뒤집기

# 각 프레임 업데이트 함수
def update(frame):
    ax.clear()  # 이전 프레임 지우기
    plt.title("dedlift")
    ax.invert_yaxis()  # y축 뒤집기

    # 각 연결 관계에 따라 선 그리기
    for point1, point2 in connections:
        try:
            x_values = [df[f'{point1}_x'][frame], df[f'{point2}_x'][frame]]
            y_values = [df[f'{point1}_y'][frame], df[f'{point2}_y'][frame]]
            ax.plot(x_values, y_values, marker='o')
        except KeyError:
            continue

    # 삼각형 그리기 및 Ankle 연결
    for side in ['L', 'R']:
        try:
            # 삼각형 꼭짓점 좌표
            big_toe = (df[f'{side}BigToe_x'][frame], df[f'{side}BigToe_y'][frame])
            small_toe = (df[f'{side}SmallToe_x'][frame], df[f'{side}SmallToe_y'][frame])
            heel = (df[f'{side}Heel_x'][frame], df[f'{side}Heel_y'][frame])

            # 삼각형 그리기
            ax.plot([big_toe[0], small_toe[0]], [big_toe[1], small_toe[1]], 'b-')
            ax.plot([small_toe[0], heel[0]], [small_toe[1], heel[1]], 'b-')
            ax.plot([heel[0], big_toe[0]], [heel[1], big_toe[1]], 'b-')
            
            # Ankle 위치
            ankle = (df[f'{side}Ankle_x'][frame], df[f'{side}Ankle_y'][frame])

            # Ankle을 삼각형의 각 꼭짓점과 연결
            ax.plot([ankle[0], big_toe[0]], [ankle[1], big_toe[1]], 'b-', marker='o')
            ax.plot([ankle[0], small_toe[0]], [ankle[1], small_toe[1]], 'b-', marker='o')
            ax.plot([ankle[0], heel[0]], [ankle[1], heel[1]], 'b-', marker='o')
            
        except KeyError:
            continue

# 애니메이션 생성
ani = FuncAnimation(fig, update, frames=len(df), init_func=init, repeat=False)

# 애니메이션 저장
ani.save('skeleton_animation.mp4', writer='ffmpeg', fps=10)
```
너무 웃긴다.  
크크크큭트트크크ㅋ..ㅜ.ㅠ