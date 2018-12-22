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
    work_m_00000000001918224885_0449082813_init();
    work_m_00000000004268987352_0471293910_init();
    work_m_00000000001199313112_1298333783_init();
    work_m_00000000002964642800_4144471541_init();
    work_m_00000000001033641066_0482075601_init();
    work_m_00000000002005932418_1621229167_init();
    work_m_00000000003112692790_4132685690_init();
    work_m_00000000002412256879_0886308060_init();
    work_m_00000000003328579962_2875975674_init();
    work_m_00000000000681275382_2580585101_init();
    work_m_00000000000448998253_2461264495_init();
    work_m_00000000002961805444_3975733304_init();
    work_m_00000000001707589796_3508751931_init();
    work_m_00000000003497011561_1386922326_init();
    work_m_00000000000714850547_0070715472_init();
    work_m_00000000001104597461_4136109235_init();
    work_m_00000000003540175942_3508565487_init();
    work_m_00000000000870399162_2782103923_init();
    work_m_00000000002800944320_0156190743_init();
    work_m_00000000001100086808_3877310806_init();
    work_m_00000000002047498008_1949555310_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002047498008_1949555310");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
