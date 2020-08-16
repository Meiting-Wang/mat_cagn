{smcl}
{right:Updated time: Aug 15, 2020}
{* -----------------------------title------------------------------------ *}{...}
{p 0 18 2}
{bf:[W-9] mat_cagn} {hline 2} solve the problem of "type mismatch" in the command Line `"mat A["mpg",1]=B[3,3]"' or the like. The source code can be gained in {browse "https://github.com/Meiting-Wang/mat_cagn":github}.


{* -----------------------------Syntax------------------------------------ *}{...}
{title:Syntax}

{p 8 8 2}
{cmd:mat_cagn} {it:matrix_cell_assignment_expression}


{* -----------------------------Contents------------------------------------ *}{...}
{title:Contents}

{p 4 4 2}
{help mat_cagn##Description:Description}{break}
{help mat_cagn##Examples:Examples}{break}
{help mat_cagn##Author:Author}{break}
{help mat_cagn##Also_see:Also see}{break}


{* -----------------------------Description------------------------------------ *}{...}
{marker Description}{title:Description}

{p 4 4 2}
{bf:mat_cagn}(matrix cell assignment), a small program for matrix assignment, aims at solve the problem of "type mismatch" in the command Line `"mat A["mpg",1]=B[3,3]"' or the like. It is worth noting that this command can only be used in version 16 or later.

{p 4 4 2}
If you want to achieve more matrix operations comparing to matrix command, see {help matmh}.


{* -----------------------------Examples------------------------------------ *}{...}
{marker Examples}{title:Examples}

{p 4 4 2}Setup{p_end}
{p 8 8 2}. mat A=(1,4,5\4,5,6\7,8,4){p_end}
{p 8 8 2}. mat rown A = r10 r12 r14{p_end}
{p 8 8 2}. mat B =(45,7,45,7\7,69,100,7\45,65,45,12\451,457,1274,54){p_end}
{p 8 8 2}. mat rown B = 1:asd 2:fge 2:weg Total:asd{p_end}
{p 8 8 2}. mat coln B = 1:csajd 1:cghas 2:cgdf Total:cjad{p_end}
{p 8 8 2}. mat list A{p_end}
{p 8 8 2}. mat list B{p_end}

{p 4 4 2}Matrix element assignment{p_end}
{p 8 8 2}. mat_cagn A[2,1] = B[3,3]{p_end}
{p 8 8 2}. mat_cagn A["r12",1] = B[3,3]{p_end}
{p 8 8 2}. mat_cagn A["r12",1] = B[3,"2:cgdf"...]{p_end}
{p 8 8 2}. mat_cagn A[2,"c1"] = B[3,3]{p_end}
{p 8 8 2}. mat_cagn A[2,"c1"] = B[3,3...]{p_end}
{p 8 8 2}. mat_cagn A["r12","c1"] = B[3,3]{p_end}
{p 8 8 2}. mat_cagn A["r12","c1"] = B[3,3...]{p_end}
{p 8 8 2}. mat_cagn B[2,"1:cghas"] = 1234{p_end}
{p 8 8 2}. mat_cagn B["2:fge",2] = A["r12"...,"c2".."c3"]{p_end}
{p 8 8 2}. mat_cagn B["2:fge","1:cghas"] = A{p_end}
{p 8 8 2}. mat_cagn B["2:fge","1:cghas"] = B["Total:asd","2:cgdf"]{p_end}


{* -----------------------------Author------------------------------------ *}{...}
{marker Author}{title:Author}

{p 4 4 2}
Meiting Wang{break}
Institute for Economic and Social Research, Jinan University{break}
Guangzhou, China{break}
wangmeiting92@gmail.com


{* -----------------------------Also see------------------------------------ *}{...}
{marker Also_see}{title:Also see}

{space 4}{help matrix}
{space 4}{help matmh}(already installed)  {col 40}{stata github install Meiting-Wang/matmh:install matmh}(to install)

