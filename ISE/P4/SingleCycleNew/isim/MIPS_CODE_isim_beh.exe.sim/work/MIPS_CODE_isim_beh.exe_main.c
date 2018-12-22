/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000001033641066_0482075601_init();
    work_m_00000000001918224885_0449082813_init();
    work_m_00000000001680629586_0471293910_init();
    work_m_00000000001789025506_1621229167_init();
    work_m_00000000002558684977_0886308060_init();
    work_m_00000000000788601789_2461264495_init();
    work_m_00000000003961629570_1917266896_init();
    work_m_00000000000614441193_4144471541_init();
    work_m_00000000001646072677_3877310806_init();
    work_m_00000000002047498008_3336847881_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002047498008_3336847881");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}