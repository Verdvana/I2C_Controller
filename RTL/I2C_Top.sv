//=============================================================================
//
//Module Name:					I2C_Top.sv
//Department:					Xidian University
//Function Description:	        I2C控制器顶层
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review		Rel data
//V1.0		Verdvana	Verdvana	Verdvana		  			2020-09-26
//
//------------------------------------------------------------------------------
//
//Version	Modified History
//V1.0      I2C_Controller的wrapper
//          包含I2C中实际的双向sda PAD	
//
//=============================================================================

`timescale 1ns/1ps


module I2C_Top #(
    parameter   SYS_CLOCK = 50_000_000,     //系统时钟频率
                SCL_CLOCK = 400_000         //I2C时钟频率
)(
    input  logic            clk,            //系统时钟
    input  logic            rst_n,          //异步复位

    I2C_Ctrl_Intf.Device    i2c_ctrl_intf_d,//i2c 控制接口（设备侧）

    output logic            done,
    output logic            error,

    output logic            scl,            //scl
    inout  wire             sda             //sda
    );

    logic   sda_i,sda_o,sda_en;

    assign  sda      = sda_en ? sda_o : 1'bz;
    assign  sda_i    = sda;


    I2C_Controller #(
        .SYS_CLOCK(SYS_CLOCK),
        .SCL_CLOCK(SCL_CLOCK)
    )u_I2C_Controller(
        .clk(clk),
        .rst_n(rst_n),

        .i2c_ctrl_intf_d(i2c_ctrl_intf_d),

        .scl(scl),
        .sda_i(sda_i),
        .sda_o(sda_o),
        .sda_en(sda_en),

        .done(done),
        .error(error)
    );

endmodule