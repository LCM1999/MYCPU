library verilog;
use verilog.vl_types.all;
entity MEM_WB_Reg is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        MEM_WB_RegWre   : in     vl_logic;
        MEM_Reg_RD      : in     vl_logic_vector(4 downto 0);
        MEM_ALU_DataBus : in     vl_logic_vector(31 downto 0);
        WB_RegWre       : out    vl_logic;
        WB_DataBus      : out    vl_logic_vector(31 downto 0);
        WB_Reg_RD       : out    vl_logic_vector(4 downto 0)
    );
end MEM_WB_Reg;