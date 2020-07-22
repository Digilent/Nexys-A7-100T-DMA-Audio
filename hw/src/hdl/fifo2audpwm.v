`timescale 1ns / 1ps
module fifo2audpwm #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DATA_WIDTH = 32
) (
    input wire clk,
    (* X_INTERFACE_INFO = "digilentinc.com:local_if:pwm_audio_rtl:1.0 PWM_AUDIO pwm" *)
    output wire aud_pwm,
    (* X_INTERFACE_INFO = "digilentinc.com:local_if:pwm_audio_rtl:1.0 PWM_AUDIO en" *)
    output reg aud_en,
    
    (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 M_FIFO_READ RD_DATA" *)
    input [FIFO_DATA_WIDTH-1:0] fifo_rd_data,
    (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 M_FIFO_READ RD_EN" *)
    output fifo_rd_en, // FIFO Read Enable (required)
    (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 M_FIFO_READ EMPTY" *)
    input fifo_empty, // FIFO Empty flag (optional)
    (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 M_FIFO_READ ALMOST_EMPTY" *)
    input fifo_almost_empty // FIFO Almost Empty flag (optional)
);
    reg [DATA_WIDTH+1:0] count = 0;
    reg [DATA_WIDTH:0] duty [3:0];
    assign fifo_rd_en = (fifo_empty == 0 && &count == 1'b1);
    always@(posedge clk)
        if (&count == 1'b1) begin
            count <= 0;
            if (fifo_empty == 0) begin
                aud_en <= 1;
                duty[0] <= fifo_rd_data[7:0];
                duty[1] <= fifo_rd_data[15:8];
                duty[2] <= fifo_rd_data[23:16];
                duty[3] <= fifo_rd_data[31:24];
            end else
                aud_en <= 0;
        end else
            count <= count + 1;
    assign aud_pwm = count[DATA_WIDTH-1:0] <= duty[count[DATA_WIDTH+1:DATA_WIDTH]];
    //assign aud_gain = 0;
endmodule