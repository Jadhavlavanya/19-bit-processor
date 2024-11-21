module ControlUnit (
   input [18:0] pc,            // Program counter
   input [18:0] addr,          // Address for jump
    input [18:0] r1,            // Register r1
    input [18:0] r2,            // Register r2
    input [3:0] ctrlOp,         // Control operation
    output reg [18:0] nextPC,   // Next program counter value
    output reg [18:0] stack[0:255], // Stack for CALL/RET
  output reg [7:0] sp        //stack pointer
);
    localparam JMP = 4'b0000;
    localparam BEQ = 4'b0001;
    localparam BNE = 4'b0010;
    localparam CALL = 4'b0011;
    localparam RET = 4'b0100;
    always @(*) begin
        case (ctrlOp)
            JMP: nextPC = addr;                            
            BEQ: nextPC = (r1 == r2) ? addr : (pc + 1);   
            BNE: nextPC = (r1 != r2) ? addr : (pc + 1);   
            CALL: begin                               
                stack[sp] = pc + 1;
                sp = sp - 1;
               nextPC = addr;
            end
            RET: begin                               
                sp = sp + 1;
                nextPC = stack[sp];
            end
            default: nextPC = pc + 1;                     
        endcase
    end
endmodule

//testbench
module ControlUnit_tb;
    reg [18:0] pc, addr, r1, r2;
    reg [3:0] ctrlOp;
    wire [18:0] nextPC;
    reg [18:0] stack [0:255];
    reg [7:0] sp;
    ControlUnit uut (
        .pc(pc), .addr(addr), .r1(r1),.r2(r2),.ctrlOp(ctrlOp),.nextPC(nextPC),.stack(stack),.sp(sp));
    initial begin
        pc = 19'd0; addr = 19'd50; r1 = 19'd10; r2 = 19'd10; sp = 8'd255;
        ctrlOp = 4'b0000; #10;
        $display("JMP: nextPC = %d (Expected: 50)", nextPC);
        ctrlOp = 4'b0001; #10;
      $display("BEQ: nextPC = %d (Expected: 50)", nextPC);
        r2 = 19'd20; ctrlOp = 4'b0001; #10;
        $display("BEQ: nextPC = %d (Expected: %d)", nextPC, pc + 1);
        ctrlOp = 4'b0011; #10;
        $display("CALL: nextPC = %d (Expected: 50), sp = %d (Expected: 254)", nextPC, sp);
        ctrlOp = 4'b0100; #10;
        $display("RET: nextPC = %d, sp = %d", nextPC, sp);
        $finish;
    end
endmodule



