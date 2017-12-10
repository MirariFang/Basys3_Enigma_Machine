// This module converts input binary number to segment display number

module AlphabetDecoder(seg0,seg1,in);
    input [4:0] in;
    output [6:0] seg0,seg1;
    wire dec0,dec1,dec2;
    wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w0;

    assign dec0= in[4:3]==2'b00|in==5'd9|in==5'd8;
    assign dec2= in==5'd20|in==5'd21|in==5'd22|in==5'd23|in==5'd24|in==5'd25|in==5'd26;
    assign dec1= in==5'd10|in==5'd11|in[4:2]==3'b011|in[4:2]==3'b100|in==5'd19;

    assign w0=in==5'd0|in==5'd10|in==5'd20;
    assign w1=in==5'd1|in==5'd11|in==5'd21;
    assign w2=in==5'd2|in==5'd12|in==5'd22;
    assign w3=in==5'd3|in==5'd13|in==5'd23;
    assign w4=in==5'd4|in==5'd14|in==5'd24;
    assign w5=in==5'd5|in==5'd15|in==5'd25;
    assign w6=in==5'd6|in==5'd16|in==5'd26;
    assign w7=in==5'd7|in==5'd17;
    assign w8=in==5'd8|in==5'd18;
    assign w9=in==5'd9|in==5'd19;

    assign seg0[0]=w1|w4;
	assign seg0[1]=w5|w6;
	assign seg0[2]=w2;
	assign seg0[3]=w1|w4|w7;
	assign seg0[4]=w1|w3|w4|w5|w7|w9;
	assign seg0[5]=w1|w2|w3|w7;
	assign seg0[6]=w0|w1|w7;

    assign seg1[0]=dec1;
    assign seg1[1]=0;
    assign seg1[2]=dec2;
    assign seg1[3]=dec1;
    assign seg1[4]=dec1;
    assign seg1[5]=dec1|dec2;
    assign seg1[6]=dec0|dec1;
endmodule
