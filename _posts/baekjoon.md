title:15552번
date: 2024-12-18
category: baekjoon
---
문제  
--
첫 줄에 테스트케이스의 개수 T가 주어진다.  
T는 최대 1,000,000이다.  
다음 T줄에는 각각 두 정수 A와 B가 주어진다.  
A와 B는 1 이상, 1,000 이하이다.  

답변
--
import sys
T = int(input()) 
for _ in range(T):
    A,B = map(int, sys.stdin.readline().split(' '))
    print(A + B)


오랜만에 하는거라 map() 안에 int()라고 쓰기도 하고 입력을 어떻게 넣어야 하는지도 해맸지만 가장 문제가 된건 runtime error
python에서는 input()을 사용하면 절대 이 runtime error의 벽을 넘을 수 없었는데 그 이유는 input은 한 줄마다 자동으로 있는 \n를 제거하고 각종 검증을 하기 때문이란다.  
(*나는 여태껏 이런 일이 내부적으로 일어나는지 오늘 처음 알았다*)  
그래서 sys.stdin.readline()을 이용하여 바로 한 줄씩 출력하게 만들 수 있다.  
이 때 \n가 제거되지 않기 때문에 줄바꿈이 화면에 나타난다.  
**But** split()을 하면 이러한 것도 제거가 되기 때문에 딱히 상관이 없다.  

*ps. 나는 그런것도 모르고 rstip()을 붙였다가 runtime error를 계속 맞았다 ㅠㅠ*
