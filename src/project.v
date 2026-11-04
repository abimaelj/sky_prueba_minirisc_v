///*
// * Copyright (c) 2024 Your Name
// * SPDX-License-Identifier: Apache-2.0
// */
//
//`default_nettype none
//
//module tt_um_example (
//    input  wire [7:0] ui_in,    // Dedicated inputs
//    output wire [7:0] uo_out,   // Dedicated outputs
//    input  wire [7:0] uio_in,   // IOs: Input path
//    output wire [7:0] uio_out,  // IOs: Output path
//    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
//    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
//    input  wire       clk,      // clock
//    input  wire       rst_n     // reset_n - low to reset
//);
//
//  // All output pins must be assigned. If not used, assign to 0.
//  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
//  assign uio_out = 0;
//  assign uio_oe  = 0;
//
//  // List all unused inputs to prevent warnings
//  wire _unused = &{ena, clk, rst_n, 1'b0};
//
//endmodule




/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_sumador8bits (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out[6:0] = 7'b000_0000;     // Cuando las salidas no se usen enviarlas a 0
  assign uio_oe  = 8'b1000_0000;    // Establezco todos los pines IO como entrada.

  // List all unused inputs to prevent warnings
 

 wire enable;
 wire [7:0] out;
 wire cout;

 assign enable = ui_in[0];    //Conecto mi enable al primer pin de ui_in
 assign uo_out [7:0] = out;   //conecto la salida a los pines de salida uo_out
 assign uio_out [7] = cout;


 sumador8bits sumador8bits_Unit(
  .clk(clk),
  .rst(rst_n),
  .enable(enable),
  .out(out),
  .cout(cout)
  )

 wire _unused = &{ena, uio_in[7:0], ui_in[7:1], 1'b0};

endmodule

