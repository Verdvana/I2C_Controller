//=============================================================================
//
//Module Name:					I2C_TB.sv
//Department:					Xidian University
//Function Description:	        I2C驱动器仿真文件
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review		Rel data
//V1.0		Verdvana	Verdvana	Verdvana		  			2020-09-27
//
//------------------------------------------------------------------------------
//
//Version	Modified History
//V1.0			
//
//=============================================================================

`timescale 1ns/1ps

module I2C_TB;

    logic       clk;
    logic       rst_n;
    logic       wen;
    logic       ren;
    logic       scl;
    logic       sda_o;
    logic       sda_i;
    logic       sda_en;

    parameter   PERIOD = 10;

    I2C_Control #(
        .SYS_CLOCK(1000000000/PERIOD),
        .SCL_CLOCK(5000000)
    )u_I2C_Control(
        .clk,
        .rst_n,
        .device_addr(7'b0010111),
        .word_addr_h(8'b01011100),
        .word_addr_l(8'b10100011),
        .num_word_addr(1'b1),
        .num_data_w(8'd3),
        .num_data_r(8'd3),
        .wen,
        .ren,
        .scl,
        .sda_i,
        .sda_o,
        .sda_en
    );

    initial begin
        clk = 0;
        forever #(PERIOD/2) clk = ~clk;
    end

    task task_init;begin
        wen = 0;
    end
    endtask

    initial begin 
        task_init;
        rst_n = 0;
        #PERIOD;
        rst_n = 1;
        
        #PERIOD;
        wen = 1;
        #PERIOD;#PERIOD;#PERIOD;#PERIOD;
        wen = 0;
        #2000;#2000;#2000;#2000;
        #2000;#2000;#2000;#2000;
        #2000;#2000;#2000;#2000;

        #PERIOD;
        wen = 1;
        #PERIOD;#PERIOD;#PERIOD;#PERIOD;
        wen = 0;
        #2000;#2000;#2000;#2000;
        #2000;#2000;#2000;#2000;
        #2000;#2000;#2000;#2000;

        #PERIOD;
        ren = 1;
        #PERIOD;#PERIOD;#PERIOD;#PERIOD;
        ren = 0;
        #2000;#2000;#2000;#2000;
        #2000;#2000;#2000;#2000;
        #2000;#2000;#2000;#2000;

        $stop;
    end

    initial begin 
        #1835;
        sda_i = '0;

        #53855;
        sda_i = '1;
        #200;
        sda_i = '0;
        #200;
        sda_i = '1;
        #200;
        sda_i = '0;
        #200;
        sda_i = '0;
        #200;
        sda_i = '0;
        #200;
        sda_i = '1;
        #200;
        sda_i = '1;
        #200;
        sda_i = '0;
    end


endmodule