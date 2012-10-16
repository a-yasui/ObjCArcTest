# ARC/NoneARC Test

ARC (Auto Reference Counter) の有無で、メモリーおよび実行速度がどれだけ影響されるか実験メモ


## ファイル構成

- ObjCUseARC/
    
    ARC 使用のプロジェクト

- ObjcNotUseARC/
    
    ARC 未使用のプロジェクト

- main.m
    
    テストプログラム。各プロジェクト共に共有させている。


## テスト概要
ARC 有り無しで、メモリー消費量と実効速度を計測する。

50 万回のランダム数値を、NSMutableArray に入れ、ソートさせて、総和を出力する。
それを10回繰り返して出力結果を見る。


今回は２つのパターンの実行をしてみる。

1. ただひたすら実行させる。
    
    ARC 無しの場合はメモリー消費量が増えていく一方だが、実行速度がどうなるかを見る
    
2. 10回の繰り返しの度に autorelease を実行して、メモリー消費量を見る
    
    ARC の有り無しで、メモリー消費量に差が出るのかを見る


## 結果

ここに記述している `Finish Sort: 1.582361 all 1.582393 memory: 31592448 byte` は、
`Finish Sort: <実行時間 (単位 msec)> all <一番初めのテスト実行からの実行時間 (単位 msec)> memory: <メモリー消費量 (単位 byte)> byte` というフォーマットになっている。

### ARC 無し

#### test1

1. Finish Sort: 1.582361 all 1.582393 memory: 31592448 byte
1. Finish Sort: 1.430619 all 3.014311 memory: 40034304 byte
1. Finish Sort: 1.844197 all 4.865976 memory: 48234496 byte
1. Finish Sort: 1.471806 all 6.339603 memory: 59146240 byte
1. Finish Sort: 1.483267 all 7.824260 memory: 67911680 byte
1. Finish Sort: 1.390733 all 9.216471 memory: 71147520 byte
1. Finish Sort: 1.334989 all 10.552684 memory: 83566592 byte
1. Finish Sort: 1.241915 all 11.795993 memory: 91570176 byte
1. Finish Sort: 1.338522 all 13.135926 memory: 95690752 byte
1. Finish Sort: 1.320365 all 14.457686 memory: 101646336 byte

All Finish: 14.458987 memory: 101646336 byte

#### test 2

1. Finish Sort: 1.251471 all 1.251483 memory: 93622272 byte
1. Finish Sort: 1.258277 all 2.511101 memory: 93622272 byte
1. Finish Sort: 1.265331 all 3.777703 memory: 93622272 byte
1. Finish Sort: 1.263425 all 5.042220 memory: 93622272 byte
1. Finish Sort: 1.261984 all 6.305470 memory: 93622272 byte
1. Finish Sort: 1.245292 all 7.552047 memory: 93622272 byte
1. Finish Sort: 1.371298 all 8.924816 memory: 93622272 byte
1. Finish Sort: 1.266756 all 10.192871 memory: 97624064 byte
1. Finish Sort: 1.297481 all 11.491416 memory: 100364288 byte
1. Finish Sort: 1.378741 all 12.871416 memory: 100958208 byte

All Finish: 12.872899 memory: 100958208 byte


### ARC 有り

#### test1

1. Finish Sort: 2.596844 all 2.596905 memory: 29286400 byte
1. Finish Sort: 2.337959 all 4.936025 memory: 37842944 byte
1. Finish Sort: 2.104560 all 7.041782 memory: 41844736 byte
1. Finish Sort: 1.991903 all 9.035344 memory: 45846528 byte
1. Finish Sort: 2.182616 all 11.219257 memory: 49922048 byte
1. Finish Sort: 2.026966 all 13.247749 memory: 54013952 byte
1. Finish Sort: 2.036593 all 15.285635 memory: 57991168 byte
1. Finish Sort: 2.070241 all 17.357126 memory: 61992960 byte
1. Finish Sort: 2.004617 all 19.362875 memory: 65994752 byte
1. Finish Sort: 1.994370 all 21.358345 memory: 69996544 byte

All Finish: 21.359485 memory: 69996544 byte


#### test2

1. Finish Sort: 2.057449 all 2.057454 memory: 53325824 byte
1. Finish Sort: 2.024423 all 4.088075 memory: 53325824 byte
1. Finish Sort: 2.012571 all 6.101931 memory: 53325824 byte
1. Finish Sort: 2.034686 all 8.137943 memory: 53325824 byte
1. Finish Sort: 2.147052 all 10.286305 memory: 53325824 byte
1. Finish Sort: 2.002599 all 12.290549 memory: 53325824 byte
1. Finish Sort: 1.995881 all 14.287713 memory: 53325824 byte
1. Finish Sort: 2.025303 all 16.314335 memory: 53325824 byte
1. Finish Sort: 1.997675 all 18.313130 memory: 53325824 byte
1. Finish Sort: 2.038336 all 20.352892 memory: 53325824 byte

All Finish: 20.354198 memory: 53325824 byte


## 考察

ARC 無しの実行速度平均が 1.3665943 msec であり、ARC 有りの実行速度平均が 2.08568415 であることを見ると、おおよそ ARC 有りの方が 1.6倍遅い。

一方で、メモリー消費量は test1 を見る限り、ARC 無しは使用容量は増えていくのに比べ、ARC 有りは低く抑えられている。


双方の test2 は一部を除き安定しているが、ARC 有りの方がメモリー消費量は低く抑えられている。test1 の 8,9,10 には疑問があるため保留。

結論としては、メモリー消費量を重視する場合は ARC 有りを使用し、実行速度重視の場合は ARC 無しを選ぶのを勧める。

## 各テスト出力結果

ARC 無し出力結果::
    
    2012-10-16 19:53:25.887 ObjcNotUseARC[57785:403] ========================================================
    2012-10-16 19:53:27.478 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:27.481 ObjcNotUseARC[57785:403] Finish Sort: 1.582361 all 1.582393 memory: 31592448 byte
    2012-10-16 19:53:28.889 ObjcNotUseARC[57785:403] Sum() => 499998.000000
    2012-10-16 19:53:28.913 ObjcNotUseARC[57785:403] Finish Sort: 1.430619 all 3.014311 memory: 40034304 byte
    2012-10-16 19:53:30.763 ObjcNotUseARC[57785:403] Sum() => 499997.000000
    2012-10-16 19:53:30.765 ObjcNotUseARC[57785:403] Finish Sort: 1.844197 all 4.865976 memory: 48234496 byte
    2012-10-16 19:53:32.237 ObjcNotUseARC[57785:403] Sum() => 499998.000000
    2012-10-16 19:53:32.238 ObjcNotUseARC[57785:403] Finish Sort: 1.471806 all 6.339603 memory: 59146240 byte
    2012-10-16 19:53:33.722 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:33.723 ObjcNotUseARC[57785:403] Finish Sort: 1.483267 all 7.824260 memory: 67911680 byte
    2012-10-16 19:53:35.114 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:35.115 ObjcNotUseARC[57785:403] Finish Sort: 1.390733 all 9.216471 memory: 71147520 byte
    2012-10-16 19:53:36.450 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:36.451 ObjcNotUseARC[57785:403] Finish Sort: 1.334989 all 10.552684 memory: 83566592 byte
    2012-10-16 19:53:37.693 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:37.695 ObjcNotUseARC[57785:403] Finish Sort: 1.241915 all 11.795993 memory: 91570176 byte
    2012-10-16 19:53:39.033 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:39.035 ObjcNotUseARC[57785:403] Finish Sort: 1.338522 all 13.135926 memory: 95690752 byte
    2012-10-16 19:53:40.355 ObjcNotUseARC[57785:403] Sum() => 499997.000000
    2012-10-16 19:53:40.356 ObjcNotUseARC[57785:403] Finish Sort: 1.320365 all 14.457686 memory: 101646336 byte
    2012-10-16 19:53:40.358 ObjcNotUseARC[57785:403] All Finish: 14.458987 memory: 101646336 byte
    2012-10-16 19:53:40.449 ObjcNotUseARC[57785:403] ========================================================
    2012-10-16 19:53:41.719 ObjcNotUseARC[57785:403] Sum() => 499997.000000
    2012-10-16 19:53:41.729 ObjcNotUseARC[57785:403] Finish Sort: 1.251471 all 1.251483 memory: 93622272 byte
    2012-10-16 19:53:42.978 ObjcNotUseARC[57785:403] Sum() => 499998.000000
    2012-10-16 19:53:42.989 ObjcNotUseARC[57785:403] Finish Sort: 1.258277 all 2.511101 memory: 93622272 byte
    2012-10-16 19:53:44.245 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:44.256 ObjcNotUseARC[57785:403] Finish Sort: 1.265331 all 3.777703 memory: 93622272 byte
    2012-10-16 19:53:45.510 ObjcNotUseARC[57785:403] Sum() => 499995.000000
    2012-10-16 19:53:45.520 ObjcNotUseARC[57785:403] Finish Sort: 1.263425 all 5.042220 memory: 93622272 byte
    2012-10-16 19:53:46.773 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:46.783 ObjcNotUseARC[57785:403] Finish Sort: 1.261984 all 6.305470 memory: 93622272 byte
    2012-10-16 19:53:48.020 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:48.030 ObjcNotUseARC[57785:403] Finish Sort: 1.245292 all 7.552047 memory: 93622272 byte
    2012-10-16 19:53:49.392 ObjcNotUseARC[57785:403] Sum() => 499997.000000
    2012-10-16 19:53:49.403 ObjcNotUseARC[57785:403] Finish Sort: 1.371298 all 8.924816 memory: 93622272 byte
    2012-10-16 19:53:50.661 ObjcNotUseARC[57785:403] Sum() => 499999.000000
    2012-10-16 19:53:50.671 ObjcNotUseARC[57785:403] Finish Sort: 1.266756 all 10.192871 memory: 97624064 byte
    2012-10-16 19:53:51.959 ObjcNotUseARC[57785:403] Sum() => 499998.000000
    2012-10-16 19:53:51.969 ObjcNotUseARC[57785:403] Finish Sort: 1.297481 all 11.491416 memory: 100364288 byte
    2012-10-16 19:53:53.339 ObjcNotUseARC[57785:403] Sum() => 499998.000000
    2012-10-16 19:53:53.349 ObjcNotUseARC[57785:403] Finish Sort: 1.378741 all 12.871416 memory: 100958208 byte
    2012-10-16 19:53:53.351 ObjcNotUseARC[57785:403] All Finish: 12.872899 memory: 100958208 byte


ARC有り出力結果::
    
    2012-10-16 19:54:30.758 ObjCUseARC[57880:403] ========================================================
    2012-10-16 19:54:33.322 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:33.394 ObjCUseARC[57880:403] Finish Sort: 2.596844 all 2.596905 memory: 29286400 byte
    2012-10-16 19:54:35.721 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:35.733 ObjCUseARC[57880:403] Finish Sort: 2.337959 all 4.936025 memory: 37842944 byte
    2012-10-16 19:54:37.828 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:37.839 ObjCUseARC[57880:403] Finish Sort: 2.104560 all 7.041782 memory: 41844736 byte
    2012-10-16 19:54:39.822 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:39.832 ObjCUseARC[57880:403] Finish Sort: 1.991903 all 9.035344 memory: 45846528 byte
    2012-10-16 19:54:42.006 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:42.016 ObjCUseARC[57880:403] Finish Sort: 2.182616 all 11.219257 memory: 49922048 byte
    2012-10-16 19:54:44.035 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:44.045 ObjCUseARC[57880:403] Finish Sort: 2.026966 all 13.247749 memory: 54013952 byte
    2012-10-16 19:54:46.072 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:46.083 ObjCUseARC[57880:403] Finish Sort: 2.036593 all 15.285635 memory: 57991168 byte
    2012-10-16 19:54:48.143 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:48.154 ObjCUseARC[57880:403] Finish Sort: 2.070241 all 17.357126 memory: 61992960 byte
    2012-10-16 19:54:50.150 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:50.160 ObjCUseARC[57880:403] Finish Sort: 2.004617 all 19.362875 memory: 65994752 byte
    2012-10-16 19:54:52.145 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:52.155 ObjCUseARC[57880:403] Finish Sort: 1.994370 all 21.358345 memory: 69996544 byte
    2012-10-16 19:54:52.156 ObjCUseARC[57880:403] All Finish: 21.359485 memory: 69996544 byte
    2012-10-16 19:54:52.254 ObjCUseARC[57880:403] ========================================================
    2012-10-16 19:54:54.265 ObjCUseARC[57880:403] Sum() => 499998.000000
    2012-10-16 19:54:54.313 ObjCUseARC[57880:403] Finish Sort: 2.057449 all 2.057454 memory: 53325824 byte
    2012-10-16 19:54:56.325 ObjCUseARC[57880:403] Sum() => 499998.000000
    2012-10-16 19:54:56.344 ObjCUseARC[57880:403] Finish Sort: 2.024423 all 4.088075 memory: 53325824 byte
    2012-10-16 19:54:58.339 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:54:58.357 ObjCUseARC[57880:403] Finish Sort: 2.012571 all 6.101931 memory: 53325824 byte
    2012-10-16 19:55:00.374 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:55:00.393 ObjCUseARC[57880:403] Finish Sort: 2.034686 all 8.137943 memory: 53325824 byte
    2012-10-16 19:55:02.523 ObjCUseARC[57880:403] Sum() => 499998.000000
    2012-10-16 19:55:02.542 ObjCUseARC[57880:403] Finish Sort: 2.147052 all 10.286305 memory: 53325824 byte
    2012-10-16 19:55:04.527 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:55:04.546 ObjCUseARC[57880:403] Finish Sort: 2.002599 all 12.290549 memory: 53325824 byte
    2012-10-16 19:55:06.524 ObjCUseARC[57880:403] Sum() => 499998.000000
    2012-10-16 19:55:06.543 ObjCUseARC[57880:403] Finish Sort: 1.995881 all 14.287713 memory: 53325824 byte
    2012-10-16 19:55:08.551 ObjCUseARC[57880:403] Sum() => 499997.000000
    2012-10-16 19:55:08.570 ObjCUseARC[57880:403] Finish Sort: 2.025303 all 16.314335 memory: 53325824 byte
    2012-10-16 19:55:10.550 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:55:10.569 ObjCUseARC[57880:403] Finish Sort: 1.997675 all 18.313130 memory: 53325824 byte
    2012-10-16 19:55:12.590 ObjCUseARC[57880:403] Sum() => 499999.000000
    2012-10-16 19:55:12.608 ObjCUseARC[57880:403] Finish Sort: 2.038336 all 20.352892 memory: 53325824 byte
    2012-10-16 19:55:12.610 ObjCUseARC[57880:403] All Finish: 20.354198 memory: 53325824 byte
