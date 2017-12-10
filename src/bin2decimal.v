module bin2decimal(i,o);
    input [7:0] i;
    output [4:0] o;

    wire alph [26:1];

    assign alph[1] = i==8'h1c;
    assign alph[2] = i==8'h32;
    assign alph[3] = i==8'h21;
    assign alph[4] = i==8'h23;
    assign alph[5] = i==8'h24;
    assign alph[6] = i==8'h2b;
    assign alph[7] = i==8'h34;
    assign alph[8] = i==8'h33;
    assign alph[9] = i==8'h43;
    assign alph[10] = i==8'h3b;
    assign alph[11] = i==8'h42;
    assign alph[12] = i==8'h4b;
    assign alph[13] = i==8'h3a;
    assign alph[14] = i==8'h31;
    assign alph[15] = i==8'h44;
    assign alph[16] = i==8'h4d;
    assign alph[17] = i==8'h15;
    assign alph[18] = i==8'h2d;
    assign alph[19] = i==8'h1b;
    assign alph[20] = i==8'h2c;
    assign alph[21] = i==8'h3c;
    assign alph[22] = i==8'h2a;
    assign alph[23] = i==8'h1d;
    assign alph[24] = i==8'h22;
    assign alph[25] = i==8'h35;
    assign alph[26] = i==8'h1a;

    assign o[0]=alph[1]|alph[3]|alph[5]|alph[7]|alph[9]|alph[11]|alph[13]|alph[15]|alph[17]|alph[19]|alph[21]|alph[23]|alph[25];
    assign o[1]=alph[2]|alph[3]|alph[6]|alph[7]|alph[10]|alph[11]|alph[14]|alph[15]|alph[18]|alph[19]|alph[23]|alph[22]|alph[26];
    assign o[2]=alph[4]|alph[5]|alph[6]|alph[7]|alph[12]|alph[13]|alph[14]|alph[15]|alph[20]|alph[21]|alph[22]|alph[23];
    assign o[3]=alph[8]|alph[9]|alph[10]|alph[11]|alph[12]|alph[13]|alph[14]|alph[15]|alph[24]|alph[25]|alph[26];
    assign o[4]=alph[16]|alph[17]|alph[18]|alph[19]|alph[20]|alph[21]|alph[22]|alph[23]|alph[24]|alph[25]|alph[26];


endmodule
