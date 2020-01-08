library verilog;
use verilog.vl_types.all;
entity ID is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        Flash           : in     vl_logic;
        InsCode         : in     vl_logic_vector(31 downto 0);
        op              : out    vl_logic_vector(5 downto 0);
        rs              : out    vl_logic_vector(4 downto 0);
        rt              : out    vl_logic_vector(4 downto 0);
        rd              : out    vl_logic_vector(4 downto 0);
        ID_immediate    : out    vl_logic_vector(15 downto 0)
    );
end ID;