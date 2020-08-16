* Description: solve the problem of "type mismatch" in the command Line `"mat A["mpg",1]=B[3,3]"' or the like
* Author: Meiting Wang, Doctor, Institute for Economic and Social Research, Jinan University
* Email: wangmeiting92@gmail.com
* Created on Aug 15, 2020


program define mat_cagn //(Matrix cell assignment, mat_cagn)
version 16
syntax anything(equalok)
/*
*-实例
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


*---------------------------注意事项-----------------------------
1. 该程序的目的在于解决类似命令行mat A["mpg",1]=B[3,3]出现type mismatch的问题
2. 该程序的思想在于：假设要完成A["trunk","hi"] = B[3,3...]的运算，首先，程序先会匹配A["trunk","hi"]所对应的行列号，如A[5,2]；然后再借用mat A[5,2]=B[3,3...]完成计算。
3. anything表达式中允许有且只有一个等号
4. 等号左端矩阵行列信息(`rc_info')不允许包含空格，更具体的，只允许一个数值或一个文本"单词"(带双引号)，如：12, "12", "price", "mean(price)", "3:mean(price)"
5. 根据该程序的思想，anything等号右边的内容只需符合类似“mat A[5,2]=B[3,3...]”等号右边表达式的格式即可，如果不符合，mat运算会自动报错
6. 我们强烈建议矩阵中行列名(行列方程名)中不要包含空格，这不仅会在该程序中出现未知错误，还会在传统的运算符中出现一些具有迷惑性的问题，比如local test: rown A; local test: rowfullnames A等
*/


*设定所输入语句的部分格式，并从中提取关键信息(如矩阵名称、矩阵行信息、矩阵列信息)
local rc_info `"([1-9]\d*|"(\w|\(|\))+"|"(\w+:(\w|\(|\))+)")"' 
if ustrregexm(`"`anything'"',`"^([A-Za-z_]\w*)\[\s*`rc_info'\s*\,\s*`rc_info'\s*\]\s*=\s*([^=]+)$"') {
	local mat_name_l = ustrregexs(1) //提取等号左边的矩阵名称(考虑到了Stata矩阵名的命名规则)
	local row_info = ustrregexs(2) //提取等号左边矩阵的行信息
	local col_info = ustrregexs(6) //提取等号左边矩阵的列信息
	local anything_r = ustrregexs(10) //提取anything等号右边的部分

	cap mat list `mat_name_l'
	if _rc {
		dis "{error:matrix `mat_name_l' not found}"
		exit
	} //确保等号左边的矩阵存在
}
else {
	dis "{error:syntax error}"
	exit
}
/*
anything等号左端表达式需符合以下类似语句：
A[2,1]
A["r12",1]
A[2,"c1"]
A["r12","c1"]
A["min(trunk)","mean(price)"]
B[2,1]
B["2:fge",1]
B[2,"1:csajd"]
B["2:fge","1:csajd"]
B["Total:asd","1:csajd"]
B["Total:asd","Total:cjad"]
B["0:mean(price)","Total:cjad"]
B["Total:mean(price)","Total:cjad"]
B["Total:cjad","0:mean(price)"]
B["Total:cjad","Total:mean(price)"]
*/


*利用等号左边矩阵的行列信息，计算出其所对应的行列号(已经考虑到了方程名存在的情况)
if ustrregexm(`"`row_info'"',"^[1-9]\d*$") {
	local row_num = `row_info'
}
else {
	local row_num: rownumb `mat_name_l' `row_info'
}

if ustrregexm(`"`col_info'"',"^[1-9]\d*$") {
	local col_num = `col_info'
}
else {
	local col_num: colnumb `mat_name_l' `col_info'
}


*当无法获得矩阵行列号或所输入行列号超过矩阵最大行列号时的返回信息(针对等号左侧矩阵)
if `row_num' == . {
	dis "{error:cannot get matrix row number from the matrix row information}"
	exit
}
else if `row_num'>`=rowsof(`mat_name_l')' {
	dis "{error:the row number inputted exceeds the maximum number of rows in the matrix}"
	exit
}

if `col_num' == . {
	dis "{error:cannot get matrix column number from the matrix column information}"
	exit
}
else if `col_num'>`=colsof(`mat_name_l')' {
	dis "{error:the column number inputted exceeds the maximum number of columns in the matrix}"
	exit
}


*通过以上所提取的等号左边矩阵的行列号信息进行矩阵运算
mat `mat_name_l'[`row_num',`col_num'] = `anything_r'
mat list `mat_name_l'
end