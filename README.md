# assignment1_ai
## 江江实现

[这篇里面挺多opencv 方法](https://blog.csdn.net/youcans/article/details/121669929)

### Step1: size adjusting

- 对于输出给定如何确定没个小块的像素？

  对于无法整除的就直接**随机**



### Step2: 图片选择--初步实现

[python实现千图成像](https://blog.csdn.net/qidu1998/article/details/79062663)

#### 方法一：直方图比较

> 伪代码
>
> - 首先将所有图片读入
>
> - 对于每一个目标小块首先计算出其直方图，对1000张图片进行一个直方图的计算
>
>   $O（N^2 (1000*2*3*a^2 + X^2 \text{距离}))$
>
>   然后将RGB三个距离直接进行一个加和<-误差很大，这种操作相当于直接计算一个灰度图像？
>
>   优化：首先计算一遍每个图片的直方图，就只用计算 $O(N^2(\text{卡方距离}))$
>
>   - 对于r g b分别计算出其卡方距离，得到一个向量，通过比较所有的最小值？
>   - 构建一个（N\*N\*N）的颜色区间，然后比较这个直方图的卡方距离
>
> - 得出距离最小的
>
>   优化：得出前十最小，然后通过别的算法进行更高准确度的确认（TODO）
>
>   目前只得到了

##### 将图片集缩小成40张图片得到的结果（运行时间13min）

![image-20221025141943192](/Users/xunyijiang/Documents/StudyMaterials/2022Fall/毛概/:Users:xunyijiang:Library:Application Support:typora-user-images:image-20221025141943192.png)

##### Compare different distance in HSV color space

###### 1. Using correlation distance

图像叫做：`comp_hist(1750,175).jpg`

![image-20221030142217354](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030142217354.png)





###### 2. Using HISTCMP_CHISQR distance

- 图像叫做：`comp_hist2(1750,175).jpg`
- 运行时间：12min26![image-20221030143604535](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030143604535.png)
- ![image-20221030143631694](/Users/xunyijiang/Documents/StudyMaterials/2022Fall/AI_B/notes/images/:Users:xunyijiang:Library:Application Support:typora-user-images:image-20221030143631694.png)





###### 3. Using HISTCMP_INTERSECT distance

- 图像名：`comp_hist3(1750,175).jpg`
- 运行时间：12min51

![image-20221030145337950](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030145337950.png)



###### 4. Using HISTCMP_BHATTACHARYYA distance

Bhattacharyya distance (In fact, OpenCV computes Hellinger distance, which is related to Bhattacharyya coefficient.)

- 图片名：`comp_hist4(1750,175).jpg`
- 运行时间：![image-20221030151253251](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030151253251.png)

![image-20221030151239953](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030151239953.png)



###### 5. Using cv.HISTCMP_KL_DIV distance

- `comp_hist5(1750,175).jpg`
- 运行时间：![image-20221030153235751](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030153235751.png)

![image-20221030153253717](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030153253717.png)





###### 6. Using HISTCMP_CHISQR_ALT distance

据说这个可以比较texture，与直接chi-square distance 类似

我实现的就是这个distance...

- `comp_hist6(1750,175).jpg`
- 运行时间：6min38

![image-20221030155153074](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030155153074.png)

`citation`

Jan Puzicha, Thomas Hofmann, and Joachim M Buhmann. Non-parametric similarity measures for unsupervised texture segmentation and image retrieval. In Computer Vision and Pattern Recognition, 1997. Proceedings., 1997 IEEE Computer Society Conference on, pages 267–272. IEEE, 1997.



##### Compare 6 distances in RGB color space

###### Target2

1. Correlation

   ![image-20221030162442961](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030162442961.png)

2. Hist-chi-square

   ![image-20221030162531045](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030162531045.png)

3. intersect

   ![image-20221030162602334](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030162602334.png)

   

4. bhattach

   ![image-20221030162627140](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030162627140.png)

   

5. KL-DIV

   ![image-20221030162652054](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030162652054.png)

   

6. chi-sqaure-alter

![image-20221030162710847](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030162710847.png)

- Running time

![image-20221030162738335](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030162738335.png)



###### Target1 at smaller dataset(40)

`comp_hist_rgb%s.jpg`

1. correlation

   ![image-20221030201944730](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030201944730.png)

2. Hist-chi

   ![image-20221030202040780](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030202040780.png)

3. hist-intersect

   ![image-20221030202109461](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030202109461.png)

4. ba

   ![image-20221030202126884](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030202126884.png)

5. kl-div

   ![image-20221030202222814](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030202222814.png)

6. Chi-alt

   ![image-20221030202248775](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030202248775.png)

7. My hist

   ![image-20221030203859449](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030203859449.png)





##### Using the pictures around

觉得不是很准会不会是因为每一次的target image 先被缩小了size，所以histogram比较的时候不是很准？-> 可以先用周围的大正方形来计算色彩？

###### 1. 考虑一个邻域内的

- `test2.jpg`

- para: 1750,1000,275,200

![image-20221030192221186](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030192221186.png)





###### 2. 不考虑邻域与上面的对比图

![image-20221030201018336](/Users/xunyijiang/Library/Application Support/typora-user-images/image-20221030201018336.png)





#### 方法二：hash

[主要参考这篇博客](https://zhuanlan.zhihu.com/p/68215900)

##### 在40张图片随机图片上的结果

##### ahash 结果（9min）

感觉不行啊

![image-20221025145432296](/Users/xunyijiang/Documents/StudyMaterials/2022Fall/毛概/images/:Users:xunyijiang:Library:Application Support:typora-user-images:image-20221025145432296.png)

##### dhash结果（11min）

![image-20221025151044973](/Users/xunyijiang/Documents/StudyMaterials/2022Fall/毛概/images/:Users:xunyijiang:Library:Application Support:typora-user-images:image-20221025151044973.png)

不行啊



##### phash结果

bug 没de 出来。。。



#### 方法三：根据LAB颜色空间

[Lab颜色空间](https://blog.csdn.net/qq_16564093/article/details/80698479)

![image-20221025142336583](/Users/xunyijiang/Documents/StudyMaterials/2022Fall/毛概/images/:Users:xunyijiang:Library:Application Support:typora-user-images:image-20221025142336583.png)

- 缺点：运行速度很慢，需要10分钟以上



#### 方法四：通过计算余弦值

。。。啥玩意

![image-20221025143626197](/Users/xunyijiang/Documents/StudyMaterials/2022Fall/毛概/images/:Users:xunyijiang:Library:Application Support:typora-user-images:image-20221025143626197.png)

#### 四种方法比较总结

感觉还是通过颜色判断比较靠谱,

从上述各种方法中可以得到自己的颜色是合理的

接下来通过这个颜色距离进行更加细致的问题



### Step3：提取图片关键颜色并缩小数据集（TODO）

[一篇类似综述的东东](https://blog.csdn.net/h532600610/article/details/52954440)

###### 如何提取一张图片的关键色彩？

###### 如何将1000张图片集缩小成需要的？

- 首先通过==颜色矩==来进行大致筛选





#### 从TOP10得到最最最合适的

##### 颜色集

https://blog.csdn.net/clannadxiaoxi/article/details/70169540

> 1. 将==rgb==划分为8个区间
> 2. 对于目标图片同样也变成拼接大小，并且计算每个像素点的颜色标号
> 3. for 循环：
>    - 对于备选图片每张图片首先进行向下采样，将其先变成拼接的大小
>    - 然后计算每个像素点的颜色标号
>    - 计算计算向量之间的距离

`test0` 是结果

##### 颜色聚合向量

https://segmentfault.com/a/1190000007536446



##### 颜色相关图



##### 分块颜色矩

> 1. Target_ij 分为四个区域，不能整除就一个小一个大
>
> 2. 对每个区域r, g, b 分别计算出一阶矩，二阶矩，三阶矩
>
>    r: [1st, 2nd, 3rd]  
>
>    g: [1st, 2nd, 3rd] 
>
>    b: [1st, 2nd, 3rd] 
>
>    转成一个1*9的向量
>
>    四个区域，则直接拼接成1*36，这样就保留了位置信息
>
> 3. 计算余弦值 or 欧氏距离







[图像分割](https://blog.csdn.net/qq_26898461/article/details/48135305)







#### 内存占用问题

#### 运行时间问题

