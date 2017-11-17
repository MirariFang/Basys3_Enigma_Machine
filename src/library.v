// dffe: D-type flip-flop with enable
//
// q      (output) - Current value of flip flop
// d      (input)  - Next value of flip flop
// clk    (input)  - Clock (positive edge-sensitive)
// enable (input)  - Load new value? (yes = 1, no = 0)
// reset  (input)  - Asynchronous reset   (reset =  1)
//
module dffe(q, d, clk, enable, reset);
   output q;
   reg    q;
   input  d;
   input  clk, enable, reset;


   always@(posedge clk or posedge reset)
     if (reset)
     begin
      q <= 1'b0;
     end
     else if (enable)
     begin
      q <= d;
     end
endmodule // dffe

// register: A register which may be reset to an arbirary value
//
// q      (output) - Current value of register
// d      (input)  - Next value of register
// clk    (input)  - Clock (positive edge-sensitive)
// enable (input)  - Load new value? (yes = 1, no = 0)
// reset  (input)  - Asynchronous reset    (reset = 1)
//
module register(q, d, clk, enable, reset);

    parameter
        width = 32,
        reset_value = 0;
 
    output reg [(width-1):0] q;
    input  [(width-1):0] d;
    input                clk, enable, reset;
 
    always@(posedge clk or posedge reset)
      if (reset == 1'b1)
        q <= reset_value;
      else if (enable == 1'b1)
        q <= d;
    
endmodule // register

////////////////////////////////////////////////////////////////////////
//
// Module: regfile
//
// Description:
//   A behavioral MIPS register file.  R0 is hardwired to zero.
//   Given that you won't write behavioral code, don't worry if you don't
//   understand how this works;  We have to use behavioral code (as 
//   opposed to the structural code you are writing), because of the 
//   latching by the the register file.
//
module regfile (rsData, rtData,
                rsNum, rtNum, rdNum, rdData, 
                rdWriteEnable, clock, reset);

    output [31:0] rsData, rtData;
    input   [4:0] rsNum, rtNum, rdNum;
    input  [31:0] rdData;
    input         rdWriteEnable, clock, reset;
    
    reg signed [31:0] r [0:31];
    integer i;

    assign rsData = r[rsNum];
    assign rtData = r[rtNum];

    always @(posedge clock or posedge reset)
    begin
        if (reset == 1'b1)
        begin
            for(i = 0; i <= 31; i = i + 1)
                r[i] <= 0;
        end
        else if ((rdWriteEnable == 1'b1) && (rdNum != 5'b0))
            r[rdNum] <= rdData;
    end
    
endmodule // regfile


// muxNv: N-input mux
module mux2v(out, A, B, sel);

   parameter
     width = 32;

   output [width-1:0] out;
   input  [width-1:0] A, B;
   input 	      sel;

   wire [width-1:0] temp1 = ({width{(!sel)}} & A);
   wire [width-1:0] temp2 = ({width{(sel)}} & B);
   assign out = temp1 | temp2;

endmodule // mux2v

module mux3v(out, A, B, C, sel);

   parameter
     width = 32;

   output [width-1:0] out;
   input  [width-1:0] A, B, C;
   input  [1:0]	      sel;
   wire   [width-1:0] wAB;

   mux2v #(width) mAB (wAB, A, B, sel[0]);
   mux2v #(width) mfinal (out, wAB, C, sel[1]);

endmodule // mux3v

module mux4v(out, A, B, C, D, sel);

   parameter
     width = 32;

   output [width-1:0] out;
   input  [width-1:0] A, B, C, D;
   input  [1:0]	      sel;
   wire   [width-1:0] wAB, wCD;

   mux2v #(width) mAB (wAB, A, B, sel[0]);
   mux2v #(width) mCD (wCD, C, D, sel[0]);
   mux2v #(width) mfinal (out, wAB, wCD, sel[1]);

endmodule // mux4v

module mux16v(out, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, sel);

   parameter
     width = 32;

   output [width-1:0] out;
   input [width-1:0]  A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P;
   input [3:0] 	      sel;

   wire [width-1:0]   wAB, wCD, wEF, wGH, wIJ, wKL, wMN, wOP;
   wire [width-1:0]   wABCD, wEFGH, wIJKL, wMNOP;
   wire [width-1:0]   wABCDEFGH, wIJKLMNOP;

   mux2v #(width)  mAB (wAB, A, B, sel[0]);
   mux2v #(width)  mCD (wCD, C, D, sel[0]);
   mux2v #(width)  mEF (wEF, E, F, sel[0]);
   mux2v #(width)  mGH (wGH, G, H, sel[0]);
   mux2v #(width)  mIJ (wIJ, I, J, sel[0]);
   mux2v #(width)  mKL (wKL, K, L, sel[0]);
   mux2v #(width)  mMN (wMN, M, N, sel[0]);
   mux2v #(width)  mOP (wOP, O, P, sel[0]);

   mux2v #(width)  mABCD (wABCD, wAB, wCD, sel[1]);
   mux2v #(width)  mEFGH (wEFGH, wEF, wGH, sel[1]);
   mux2v #(width)  mIJKL (wIJKL, wIJ, wKL, sel[1]);
   mux2v #(width)  mMNOP (wMNOP, wMN, wOP, sel[1]);

   mux2v #(width)  mABCDEFGH (wABCDEFGH, wABCD, wEFGH, sel[2]);
   mux2v #(width)  mIJKLMNOP (wIJKLMNOP, wIJKL, wMNOP, sel[2]);

   mux2v #(width)  mfinal (out, wABCDEFGH, wIJKLMNOP, sel[3]);

endmodule // mux16v

module mux32v(out, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p,
	          A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, sel);

   parameter
     width = 32;

   output [width-1:0] out;
   input [width-1:0]  a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p;
   input [width-1:0]  A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P;
   input [4:0] 	      sel;
   wire [width-1:0]   wUPPER, wlower;

   mux16v #(width) m0(wlower, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, sel[3:0]);
   mux16v #(width) m1(wUPPER, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, sel[3:0]);
   mux2v  #(width) mfinal (out, wlower, wUPPER, sel[4]);

endmodule // mux32v

module halfadder(s, c, a, b);
    output s, c;
    input  a, b;
    wire   w1, w2, not_a, not_b;

    // the "c" output is just the AND of the two inputs
    and a1(c, a, b);

    // the "s" output is 1 only when exactly one of the inputs is 1
    not n1(not_a, a);
    not n2(not_b, b);
    and a2(w1, a, not_b);
    and a3(w2, b, not_a);
    or  o1(s, w1, w2);
endmodule

module fulladder(s, cout, a, b, cin);
   output s, cout;
   input  a, b, cin;
   wire   partial_s, partial_c1, partial_c2;

   halfadder ha0(partial_s, partial_c1, a, b);
   halfadder ha1(s, partial_c2, partial_s, cin);
   or  o1(cout, partial_c1, partial_c2);

endmodule

module DecimalDigitDecoder(
	input [15:0] binary,
	output reg [3:0] tenthousands,
	output reg [3:0] thousands,
	output reg [3:0] hundreds,
	output reg [3:0] tens,
	output reg [3:0] ones
	);
	integer i;
	always @(binary)
	begin
		tenthousands = 4'd0;
		thousands = 4'd0;
		hundreds = 4'd0;
		tens = 4'd0;
		ones = 4'd0;

		for(i=15;i>=0;i=i-1)
		begin
		    if(tenthousands>=5)
                tenthousands=tenthousands+3;
		    if(thousands>=5)
                thousands=thousands+3;
			if(hundreds>=5)
				hundreds=hundreds+3;
			if(tens>=5)
				tens=tens+3;
			if(ones>=5)
				ones=ones+3;

			tenthousands = tenthousands << 1;
            tenthousands[0] = thousands[3];

			thousands = thousands << 1;
            thousands[0] = hundreds[3];

			hundreds = hundreds << 1;
			hundreds[0] = tens[3];

			tens = tens << 1;
			tens[0] = ones[3];

			ones = ones << 1;
			ones[0] = binary[i];
		end
	end
endmodule
