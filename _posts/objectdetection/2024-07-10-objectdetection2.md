---
title: model2
date: 2024-07-10
categories: objectdetection
layout: post
---
# anchor 
https://github.com/chullhwan-song/Reading-Paper/issues/184
![anchor box](/assets/hnv/anchor.png)
- [0, 0, 256, 256] > [ y center, x center, h, w] 인 사각형을 기준으로 하여 aspect ratio 가 0.5, 1, 2인 사각형을 한 개씩 만든다
    - 그럼 base anchor가 3개 만들어짐

```python
def enum_scales(base_anchor, anchor_scales, name='enum_scales'):

    '''
    :param base_anchor: [y_center, x_center, h, w]
    :param anchor_scales: different scales, like [0.5, 1., 2.0]
    :return: return base anchors in different scales.
            Example:[[0, 0, 128, 128],[0, 0, 256, 256],[0, 0, 512, 512]]
    '''
    with tf.variable_scope(name):
        anchor_scales = tf.reshape(anchor_scales, [-1, 1])  # torh.reshape(anchor_scales, [-1,1])

        return base_anchor * anchor_scales
```

![reshape](/assets/hnv/reshape.png)  
![reshape](/assets/hnv/reshape_output.png)  
각 인덴스는 해당 차원의 요소의 개수를 의미하며 -1은 자동으로 나머지 차원의 수에 맞게 요소의 개수를 조정하라는 의미  

```python
def enum_ratios(anchors, anchor_ratios, name='enum_ratios'):

    '''
    :param anchors: base anchors in different scales
    :param anchor_ratios:  ratio = h / w
    :return: base anchors in different scales and ratios
    '''

    with tf.variable_scope(name):
        _, _, hs, ws = tf.unstack(anchors, axis=1)  # torch에서는 axis 대신 dim,  unstack 대신 unbind 을 사용
        sqrt_ratios = tf.sqrt(anchor_ratios)
        sqrt_ratios = tf.expand_dims(sqrt_ratios, axis=1)  # torch는 unsqueeze(sqrt_ratios, dim=1)
        ws = tf.reshape(ws / sqrt_ratios, [-1])
        hs = tf.reshape(hs * sqrt_ratios, [-1])
        # assert tf.shape(ws) == tf.shape(hs), 'h shape is not equal w shape'

        num_anchors_per_location = tf.shape(ws)[0]  # torch에서는 tensor.shape

        return tf.transpose(tf.stack([tf.zeros([num_anchors_per_location, ]),
                                      tf.zeros([num_anchors_per_location,]),
                                      ws, hs]))
```
![axis](/assets/hnv/axis.png)
axis는 그냥 바깥쪽에서 부터 0 으로 시작해서 안쪽으로 으로 들어갈수록 수가 커지게  
axis를 그냥 방향이라고 생각하면 될 듯  

<pre>
array([[0, 1, 2],

       [3, 4, 5]])이면
axis=0 은 [0, 1, 2] - > [3, 4, 5] 
axis=1 은 0 -> 1 -> 2 또는 3-> 4 -> 5
같은 방향을 향하는 애들끼리 같이 묶여 있다고 생각하면 될 듯

</pre>  
### unsqueeze
![unsqueeze](/assets/hnv/unsqueeze.png)  
![unsqueeze](/assets/hnv/unsqueeze2.png)  

### shape
![shape](/assets/hnv/shape.png)  


### transpose
![transpose](/assets/hnv/transpose.png)  

```python
if __name__ == '__main__':

    base_anchor  = tf.constant([0, 0, 256, 256], dtype=tf.float32) #[center_y, cetner_x, h, w]
    anchor_scales = tf.constant([1.0], dtype=tf.float32)
    anchor_ratios = tf.constant([0.5, 1.0, 2.0], dtype=tf.float32)

    anchor_scales_ratios = enum_ratios(enum_scales(base_anchor, anchor_scales), anchor_ratios)
    # print(anchor_scales_ratios.shape) # (3, 4) > 3개의 aspect ratio당 > rectangle 위치 [center_y, cetner_x, h, w]

    sess = tf.Session()  # 이제는 없어진 기능
    print (sess.run(anchor_scales_ratios))
    # [center_y, cetner_x, h, w] 이므로, 중심(x, y) = (0, 0), (w, h) = (362.03867, 181.01933)
    # [[  0.        0.      362.03867 181.01933] # 0.5
    # [  0.        0.      256.      256.     ]  # 1.0
    # [  0.        0.      181.01933 362.03867]] # 2.0 <aspect ratio
```
