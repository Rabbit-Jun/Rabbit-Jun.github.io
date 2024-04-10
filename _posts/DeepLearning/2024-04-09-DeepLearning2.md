---
title: "신경망 학슴"
date: 2024-04-09
categories: deep
layout: post
---
# 배치사이즈
- 컴퓨터의 메모리 성능 때문에 배치 사이즈를 적당히 설정하는 것( 성능만 되면 일일이 쫘악 보고 병렬 처리하는게 빠름)
- 통계적으로 데이터를 일일이 랜덤하게 보면global minimum 나올수 있음 (손실함수에서)
- 한번에 모든 데이터를 보면 local minimum 빠질 수 있음
 
 # meshgrid
 