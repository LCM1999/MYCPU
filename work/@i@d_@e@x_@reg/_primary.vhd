library verilog;
use verilog.vl_types.all;
entity ID_EX_Reg is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        MEM_WB_Con      : in     vl_logic_vector(3 downto 0);
        ALUOp           : in     vl_logic_vector(2 downto 0);
        ID_Reg_RS       : in     vl_logic_vector(4 downto 0);
        ID_Reg_RT       : in     vl_logic_vector(4 downto 0);
        ID_Reg_RD       : in     vl_logic_vector(4 downto 0);
        ID_immediate    : in     vl_logic_vector(31 downto 0);
        DataBusA        : in     vl_logic_vector(31 downto 0);
        DataBusB        : in     vl_logic_vector(31 downto 0);
        MEM_Con         : out    vl_logic_vector(1 downto 0);
        WB_Con          : out    vl_logic_vector(1 downto 0);
        ALUCon          : out    vl_logic_vector(2 downto 0);
        ID_EX_Reg_RS    : out    vl_logic_vector(4 downto 0);
        ID_EX_Reg_RT    : out    vl_logic_vector(4 downto 0);
        ID_EX_Reg_RD    : out    vl_logic_vector(4 downto 0);
        ID_EX_Reg_immediate: out    vl_logic_vector(31 downto 0);
        ID_EX_DataBusA  : out    vl_logic_vector(31 downto 0);
        ID_EX_DataBusB  : out    vl_logic_vector(31 downto 0)
    );
end ID_EX_Reg;