---
layout: post
title: "utils of object-detection"
date: 2024-04-03
categories: hnv
---
# defaultdict from collections

- 파이썬의 내장 모듈에 정의된 클래스로 dict에 없는 키에 대한 첫 접근 시, 미리 지정된 기본값을 반환한다

# json

- 데이터를 파싱하거나 생성하기 위해 사용된다
- 경량의 데이터 교환 형식으로, 사람이 읽을 수 있으며 컴퓨터가 파싱하고 생성하기 쉽게 설계되었다.

# COCO from pycocotools.coco

- coco 데이터셋을 로드하고 처리하는 데 사용
    - COCO(Common Objects in Context)
# COCO from pycocotools.cocoeval

- COCO데이터셋의 평가를 위해 설계되었다.
- COCO 데이터셋의 평가 지표를 계산하는 공식 방법을 구현
- 사용자는 모델이 생성한 검출 결과를 COCO형식으로 제출하고, COCOeval 클래스를 사용하여 이 결과를 COCO데이터셋의 정답과 비교하여 평가 가능

# COCO 데이터셋

- 컴퓨터 비전 연구 분야에서 널리 사용되는 대규모 이미지 데이터셋

# df = df.sample(frac=1).reset_index(drop=True)

- frac=1 파라미터는 반환되는 샘플의 비율을 의미
    - DataFrame의 100%를 무작위로 샘플링하여, 사싨ㅇ 전체 DataFrame을 무작우 순서로 섞는 것과 같다

- reset_index(drop=True) 섞인 DataFrame의 인덱스를 재설정, 기존의 인덱스를 새로운 순서대로 0부터 시작하는 정수 인덱스로 바꾼다.

# coco_dt = self.coco_gt.loadRes(self.detections)

- self.coco_gt는 COCO 데이터셋의 ground truth 정보를 로드하고 저장하는 COCO 클래스의 인스턴스입니다. 여기서 ground truth는 이미지에 실제로 존재하는 객체들에 대한 정확한 정보를 말합니다.
    - 객체의 위치와 카테고리 정보를 포함합니다.

- loadRes 메서드는 COCO 클래스에 정의된 메서드 중 하나로, 모델에 의해 생성된 검출 결과를 로드하는 데 사용됩니다.
    - 이 메서드를 사용하면, 모델이 이미지에서 감지한 객체들에 대한 정보(예: 경계 상자, 카테고리 ID, 신뢰도 점수)를 포함하는 데이터(주로 JSON 형식)를 COCO 객체로 변환할 수 있습니다.

