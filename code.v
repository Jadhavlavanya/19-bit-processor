module ALU_19bit(input[18:0]r2,input[18:0]r3,input[3:0]ALUOp,ALU operation output reg[18:0]r1,output Zero);
localparam ADD=4'b0000;
localparam SUB=4'b0001;
localparam MUL=4'b0010;
localparam DIV=4'b0011;
  localparam INC=4'b0100;
  localparam Dec=4'b0101;
  localparam AND_OP=4'b0110;
  localparam OR_OP=4'b0111;
  localparam XOR_OP=4'b1000;
    localparam NOT_OP=4'b1001;
  always@()begin
    case(ALUOp)
      ADD:r1=r2+r2;
       SUB:r2=r2-r3;
       MUL:r1=r2*r3;
       DIV:r1=r2/r3;
      Inc:r1=r1+1;
      Dec:r1=r1-1;
      AND_OP:r1=r2&r3;
    OR_OP:r1=r2|r3;
      XOR_OP:r1=r2^r3;
      NOT_OP:r1=~r2;
      default:r1=19'b0;
    endcase
  end
  assign Zero=(r1==19'b0);
  end module
//test bench

  module ALU_19bit_tb();
    inputds//
    reg [18:0] r3;
    reg [18:0] r2;
    reg [3:0] ALUOp;

    // Outputs
    wire [18:0] r1;
    wire Zero;

    // Instantiate the ALU module
    ALU_19bit uut (
      .r1(r1),
      .r2(r2),.r3(r3),
        .ALUOp(ALUOp),
        .Result(Result),
        .Zero(Zero)
    );

    initial begin
        // Test ADD operation
        r2 = 19'd10; r3= 19'd5; ALUOp = 4'b0000; #10;
      $display("ADD: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r2 = 19'd5; r3= 19'd10; ALUOp = 4'b0001; #10;
      $display("SUB: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r2= 19'd4; r3= 19'd3; ALUOp = 4'b0010; #10;
      $display("MUL: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r2= 19'd2; r3= 19'd10; ALUOp = 4'b0011; #10;
      $display("DIV: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r1= 19'd15; ALUOp = 4'b0100; #10;
      $display("INC: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r1= 19'd15; ALUOp = 4'b0101; #10;
      $display("DEC: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r2 = 19'd0; r3= 19'd0; ALUOp = 4'b0000; #10;
      $display("ADD: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r2 = 19'b1010101010101010101,r3= 19'b1111111111111111111, ALUOp = 4'b0110,#10;
      $display("AND_OP: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r2 = 19'b1010101010101010101,r3= 19'b0101010101010101010, ALUOp = 4'b0111,#10;
      $display("OR_OP: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r2= 19'b1010101010101010101,r3= 19'b0101010101010101010,ALUOp = 4'b1000,#10;
      $display("NOT_not": r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        r2= 19'b1010101010101010101,r3= 19'b0,ALUOp = 4'b1001,#10;
      $display("zero: r2=%d, r3=%d, r1=%d, Zero=%b", r2, r3, r1, Zero);
        $finish;
    end

endmodule




    
