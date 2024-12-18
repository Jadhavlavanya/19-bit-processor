
module CustomInstructions (
    input [18:0] r2,
    input [18:0] r3,
    input [1:0] customOp,
    output reg [18:0] r1
);
    localparam FFT = 2'b00;
    localparam ENC = 2'b01;
    localparam DEC = 2'b10;
    always @(*) begin
        case (customOp)
            FFT: r1 = /* FFT operation logic */;
            ENC: r1 = /* Encryption logic */;
            DEC: r1= /* Decryption logic */;
            default: Result = 19'b0;
        endcase
    enductions_tb;
    reg [18:0] r2;
    reg [18:0] r3;
    reg [1:0] customOp;
    wire [18:0] r1;
endmodule

//testbench
    CustomInstructions UUT ( .r2(r2),.r3(r3),.customOp(customOp),.r1(r1));
    initial begin
        r2= 19'h00123; r3= 19'h00456; customOp = 2'b00;
        #10; 
        $display("FFT: r2= %h, r3 = %h, r1= %h", r2,r3,r1);
        r2= 19'h0789A; r3= 19'h01234; customOp = 2'b01;
        #10;
        $display("ENC: r2= %h, r3= %h, r1 = %h", r2,r3,r1);
        r2 = 19'h0ABCD; r3 = 19'h0F123; customOp = 2'b10;
        #10;
        $display("DEC: r2 = %h, r3 = %h, r1 = %h", r2, r3, r1);
        customOp = 2'b11;
        #10;
        $display("Default: r2 = %h, r3 = %h, r1 = %h", r2,r3,r1);
       end
      endmodule



