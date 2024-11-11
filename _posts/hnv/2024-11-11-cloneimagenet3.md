---
title: if __name__ == "__main__"
date: 2024-11-11
categories: hnv
layout: post
---
# main.py 훝어보기

```python
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-m', '--model', type=str, default='resnet')
    parser.add_argument('-b', '--batch_size', dest='batch', type=int, default =32)
    parser.add_argument('-e', '--epoch', type=int, default=50)
    parser.add_argument('-d', '--data_path', dest='data', type=str, default='../dataset')
    parser.add_argument('-s', '--save_path', dest='save', type=str, defaul='./checkpoint/')
    parser.add_argument('dc', '--device', type=str, default= 'gpu')
    parser.add_argument('-g', '--gpus', type=str, nargs= '+', default ='0')
    parser.add_argument('-p', '--precision', type=str, default='32-ture')
    parser.add_argument('-mo', '--mode', type=str, default ='train')
    parser.add_argument('-c', '--ckpt_path', dest='ckpt',type=str, default='./checkpoint/')
    args = parser.parse_args()

    main(args.model, args.data, args.batch, args.epoch, args.save, args.device, args.precision, args.mode, args.ckpt)
```
- `if __name__ == "__main__":`은 해당 스크립트를 직접 실행할 때만 그 안의 콛가 실행되도록 하는 역할을 한다.  

- `argparse.ArgumentParser()` 는 Python의 `argparse` 모듈을 이용해 명령줄 인자를 정의하고 파싱하기 위한 기본 객체를 생성  
이를 통해 명령줄에서 스크립트에 전달할 인자를 정의하고, 사용자가 입력한 인자를 Python 코드 내에서 사용 가능  

- `add_argument('-m', '--model', type=str, default='resnet')`는 `-m` 또는 `--model` 옵션으로 모델 설정, 아무것도 지정안하면 기본은 `resnet` *ex) python main.py -m 'vgg'

- `args =parse_args()`는 명령줄에서 입력한 인자들을 `args` 변수에 저장하여, 이후 코드에서 `args.m` 또는 `args.model`을 통해 입력된 값을 사용할 수 있다.  

- `    main(args.model, args.data, args.batch, args.epoch, args.save, args.device, args.precision, args.mode, args.ckpt)` 그리고 `main`함수에 인자로 넣어준다.  

- `dest`는 파싱된 값이 저장될 변수의 이름을 지정할 때 사용.
    - ex) `parser.add_argument('-b', '--batch_size', dest='batch', type=int, default=32)`와 같이 설정하면, 명령줄에서 `-b` 또는 `--batch_size`로 받은 값은 `args.batch`로 접근할 수 있습니다.
    - ex) `python main.py -b 64` 이 경우, `args.batch`의 값은 64로 설정됩니다.


- `nargs`는  `argparse`에서 인자의 개수를 지정하는 옵션
    - `'+'`: ㅎ나 이상의 인자를 받을 때 사용 *ex) -g 0 1 2 이렇게 하면 ['0','1','2']라는 리스트 전달*
    - `'*'` : 0개 이상의 인자를 받을 수 있으며 `-g` 뒤에 아무 값도 주지 않아도 오류가 발생하지 않으며, 값이 주어지면 여러 값을 리스트로 받는다.
    - `?`: 최대 1개의 인자를 받을 때 사용, 값이 없으면 `None` 또는 기본값 할당
