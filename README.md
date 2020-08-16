# Stata 小程序：mat_cagn——解决类似 mat A["mpg",1]=B[3,3] 出现 type mismatch 的问题

> 作者：王美庭  
> Email: wangmeiting92@gmail.com

## 目录

- **一、引言**
- **二、命令的安装**
- **三、语法与选项**
- **四、实例**
- **五、输出效果展示**

## 一、引言

在进行`mat`运算时，明明`mat B[3,3]=A["mpg",1]`不会出现问题，而`mat A["mpg",1]=B[3,3]`却不行，甚是想不通，于是自己写了个小程序来解决这个问题。

`mat A["mpg",1]=B[3,3]`之所以会出现 type mismatch 的问题，是因为等式左边在指定矩阵行列元素时使用了非数字。这里编程的思想在于让其对应到矩阵具体的行列号即可解决问题。

## 二、命令的安装

`mat_cagn`命令以及本人其他命令的代码都托管于 GitHub 上，读者可随时下载安装这些命令。

你可以通过系统自带的`net`命令进行安装：

```stata
net install mat_cagn, from("https://raw.githubusercontent.com/Meiting-Wang/mat_cagn/master")
```

也可以通过`github`外部命令进行安装（`github`命令本身可以通过`net install github, from("https://haghish.github.io/github/")`进行安装）：

```stata
github install Meiting-Wang/mat_cagn
```

## 三、语法与选项

**命令语法**：

```stata
mat_cagn matrix_cell_assignment_expression
```

## 四、实例

```stata
mat A=(1,4,5\4,5,6\7,8,4)
mat rown A = r10 r12 r14
mat B =(45,7,45,7\7,69,100,7\45,65,45,12\451,457,1274,54)
mat rown B = 1:asd 2:fge 2:weg Total:asd
mat coln B = 1:csajd 1:cghas 2:cgdf Total:cjad
mat list A
mat list B

mat_cagn A[2,1] = B[3,3]
mat_cagn A["r12",1] = B[3,3]
mat_cagn A["r12",1] = B[3,"2:cgdf"...]
mat_cagn A[2,"c1"] = B[3,3]
mat_cagn A[2,"c1"] = B[3,3...]
mat_cagn A["r12","c1"] = B[3,3]
mat_cagn A["r12","c1"] = B[3,3...]

mat_cagn B[2,"1:cghas"] = 1234
mat_cagn B["2:fge",2] = A["r12"...,"c2".."c3"]
mat_cagn B["2:fge","1:cghas"] = A
mat_cagn B["2:fge","1:cghas"] = B["Total:asd","2:cgdf"]
```

> 以上所有实例都可以在`help mat_cagn`中找到。  
> ![image](https://user-images.githubusercontent.com/42256486/90331844-62bb3a00-dfea-11ea-895c-1210eca54031.png)

## 五、输出效果展示

```stata
. mat A=(1,4,5\4,5,6\7,8,4)

. mat rown A = r10 r12 r14

. mat B =(45,7,45,7\7,69,100,7\45,65,45,12\451,457,1274,54)

. mat rown B = 1:asd 2:fge 2:weg Total:asd

. mat coln B = 1:csajd 1:cghas 2:cgdf Total:cjad

. mat list A

A[3,3]
     c1  c2  c3
r10   1   4   5
r12   4   5   6
r14   7   8   4

. mat list B

B[4,4]
                1:      1:      2:  Total:
            csajd   cghas    cgdf    cjad
    1:asd      45       7      45       7
    2:fge       7      69     100       7
    2:weg      45      65      45      12
Total:asd     451     457    1274      54

.
. mat_cagn A[2,1] = B[3,3]

A[3,3]
     c1  c2  c3
r10   1   4   5
r12  45   5   6
r14   7   8   4

. mat_cagn A["r12",1] = B[3,3]

A[3,3]
     c1  c2  c3
r10   1   4   5
r12  45   5   6
r14   7   8   4

. mat_cagn A["r12",1] = B[3,"2:cgdf"...]

A[3,3]
     c1  c2  c3
r10   1   4   5
r12  45  12   6
r14   7   8   4

. mat_cagn A[2,"c1"] = B[3,3]

A[3,3]
     c1  c2  c3
r10   1   4   5
r12  45  12   6
r14   7   8   4

. mat_cagn A[2,"c1"] = B[3,3...]

A[3,3]
     c1  c2  c3
r10   1   4   5
r12  45  12   6
r14   7   8   4

. mat_cagn A["r12","c1"] = B[3,3]

A[3,3]
     c1  c2  c3
r10   1   4   5
r12  45  12   6
r14   7   8   4

. mat_cagn A["r12","c1"] = B[3,3...]

A[3,3]
     c1  c2  c3
r10   1   4   5
r12  45  12   6
r14   7   8   4

.
. mat_cagn B[2,"1:cghas"] = 1234

B[4,4]
                1:      1:      2:  Total:
            csajd   cghas    cgdf    cjad
    1:asd      45       7      45       7
    2:fge       7    1234     100       7
    2:weg      45      65      45      12
Total:asd     451     457    1274      54

. mat_cagn B["2:fge",2] = A["r12"...,"c2".."c3"]

B[4,4]
                1:      1:      2:  Total:
            csajd   cghas    cgdf    cjad
    1:asd      45       7      45       7
    2:fge       7      12       6       7
    2:weg      45       8       4      12
Total:asd     451     457    1274      54

. mat_cagn B["2:fge","1:cghas"] = A

B[4,4]
                1:      1:      2:  Total:
            csajd   cghas    cgdf    cjad
    1:asd      45       7      45       7
    2:fge       7       1       4       5
    2:weg      45      45      12       6
Total:asd     451       7       8       4

. mat_cagn B["2:fge","1:cghas"] = B["Total:asd","2:cgdf"]

B[4,4]
                1:      1:      2:  Total:
            csajd   cghas    cgdf    cjad
    1:asd      45       7      45       7
    2:fge       7       8       4       5
    2:weg      45      45      12       6
Total:asd     451       7       8       4
```
