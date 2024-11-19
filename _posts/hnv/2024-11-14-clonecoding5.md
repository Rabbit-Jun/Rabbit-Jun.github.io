---
title: main2
date: 2024-11-14
categories: hnv
layout: post
---
# class 에서 모르는 것만 하자
이제는 시간이 별로 없다.  
그냥 대충 해야겠다.  

`todolist()`는 파이썬에서 리스트나 배열 등을 리스트 타입으로 변환해주는 함수입니다. 주로 아래와 같은 상황에서 사용됩니다.

Pandas Series나 DataFrame의 특정 열을 리스트로 변환할 때:
```python
import pandas as pd
df = pd.DataFrame({'col1': [1, 2, 3], 'col2': [4, 5, 6]})
col1_list = df['col1'].tolist()  # [1, 2, 3]

```  

Numpy 배열을 리스트로 변환할 때:
```
import numpy as np
array = np.array([1, 2, 3])
list_from_array = array.tolist()  # [1, 2, 3]
```