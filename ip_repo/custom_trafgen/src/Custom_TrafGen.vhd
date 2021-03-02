--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
--Date        : Mon Jan  4 17:55:30 2021
--Host        : qce-alveo01.ewi.tudelft.nl running 64-bit CentOS Linux release 7.9.2009 (Core)
--Command     : generate_target Custom_TrafGen.bd
--Design      : Custom_TrafGen
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity trafgen_custom_imp_2A8DKV is
  port (
    M_AXIS_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXIS_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_tlast : out STD_LOGIC;
    M_AXIS_tready : in STD_LOGIC;
    M_AXIS_tvalid : out STD_LOGIC;
    Op2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC
  );
end trafgen_custom_imp_2A8DKV;

architecture STRUCTURE of trafgen_custom_imp_2A8DKV is
  component Custom_TrafGen_util_vector_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 30 downto 0 );
    Op2 : in STD_LOGIC_VECTOR ( 30 downto 0 );
    Res : out STD_LOGIC_VECTOR ( 30 downto 0 )
  );
  end component Custom_TrafGen_util_vector_logic_0_0;
  component Custom_TrafGen_util_vector_logic_1_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Op2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component Custom_TrafGen_util_vector_logic_1_0;
  component Custom_TrafGen_util_vector_logic_2_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component Custom_TrafGen_util_vector_logic_2_0;
  component Custom_TrafGen_xlconstant_2_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );
  end component Custom_TrafGen_xlconstant_2_0;
  component Custom_TrafGen_xlconstant_3_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component Custom_TrafGen_xlconstant_3_0;
  component Custom_TrafGen_c_counter_binary_0_0 is
  port (
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 30 downto 0 )
  );
  end component Custom_TrafGen_c_counter_binary_0_0;
  component Custom_TrafGen_util_reduced_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 30 downto 0 );
    Res : out STD_LOGIC
  );
  end component Custom_TrafGen_util_reduced_logic_0_0;
  component Custom_TrafGen_axis_subset_converter_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_tlast : out STD_LOGIC
  );
  end component Custom_TrafGen_axis_subset_converter_0_0;
  component Custom_TrafGen_xlslice_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 30 downto 0 )
  );
  end component Custom_TrafGen_xlslice_0_0;
  component Custom_TrafGen_xlslice_1_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component Custom_TrafGen_xlslice_1_0;
  component Custom_TrafGen_c_counter_binary_1_0 is
  port (
    CLK : in STD_LOGIC;
    CE : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component Custom_TrafGen_c_counter_binary_1_0;
  component Custom_TrafGen_util_vector_logic_3_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component Custom_TrafGen_util_vector_logic_3_0;
  component Custom_TrafGen_util_vector_logic_4_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Op2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component Custom_TrafGen_util_vector_logic_4_0;
  component Custom_TrafGen_util_reduced_logic_1_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 30 downto 0 );
    Res : out STD_LOGIC
  );
  end component Custom_TrafGen_util_reduced_logic_1_0;
  signal Conn1_TDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal Conn1_TKEEP : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal Conn1_TLAST : STD_LOGIC;
  signal Conn1_TREADY : STD_LOGIC;
  signal Conn1_TVALID : STD_LOGIC;
  signal Op2_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ap_clk_1 : STD_LOGIC;
  signal ap_rst_n_1 : STD_LOGIC;
  signal axis_register_slice_0_s_axis_tready : STD_LOGIC;
  signal c_counter_binary_0_Q : STD_LOGIC_VECTOR ( 30 downto 0 );
  signal c_counter_binary_1_Q : STD_LOGIC_VECTOR ( 0 to 0 );
  signal util_reduced_logic_0_Res : STD_LOGIC;
  signal util_reduced_logic_1_Res : STD_LOGIC;
  signal util_vector_logic_0_Res : STD_LOGIC_VECTOR ( 30 downto 0 );
  signal util_vector_logic_1_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal util_vector_logic_2_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal util_vector_logic_3_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal util_vector_logic_4_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xlconstant_2_dout : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal xlconstant_3_dout : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal xlslice_0_Dout : STD_LOGIC_VECTOR ( 30 downto 0 );
  signal xlslice_1_Dout : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  Conn1_TREADY <= M_AXIS_tready;
  M_AXIS_tdata(63 downto 0) <= Conn1_TDATA(63 downto 0);
  M_AXIS_tkeep(7 downto 0) <= Conn1_TKEEP(7 downto 0);
  M_AXIS_tlast <= Conn1_TLAST;
  M_AXIS_tvalid <= Conn1_TVALID;
  Op2_1(31 downto 0) <= Op2(31 downto 0);
  ap_clk_1 <= ap_clk;
  ap_rst_n_1 <= ap_rst_n;
axis_subset_converter_0: component Custom_TrafGen_axis_subset_converter_0_0
     port map (
      aclk => ap_clk_1,
      aresetn => ap_rst_n_1,
      m_axis_tdata(63 downto 0) => Conn1_TDATA(63 downto 0),
      m_axis_tkeep(7 downto 0) => Conn1_TKEEP(7 downto 0),
      m_axis_tlast => Conn1_TLAST,
      m_axis_tready => Conn1_TREADY,
      m_axis_tvalid => Conn1_TVALID,
      s_axis_tdata(63 downto 0) => xlconstant_2_dout(63 downto 0),
      s_axis_tkeep(7 downto 0) => xlconstant_3_dout(7 downto 0),
      s_axis_tlast => util_vector_logic_1_Res(0),
      s_axis_tready => axis_register_slice_0_s_axis_tready,
      s_axis_tvalid => util_vector_logic_4_Res(0)
    );
c_counter_binary_0: component Custom_TrafGen_c_counter_binary_0_0
     port map (
      CE => axis_register_slice_0_s_axis_tready,
      CLK => ap_clk_1,
      Q(30 downto 0) => c_counter_binary_0_Q(30 downto 0),
      SCLR => util_vector_logic_1_Res(0)
    );
c_counter_binary_1: component Custom_TrafGen_c_counter_binary_1_0
     port map (
      CE => util_vector_logic_1_Res(0),
      CLK => ap_clk_1,
      Q(0) => c_counter_binary_1_Q(0),
      SCLR => xlslice_1_Dout(0)
    );
util_reduced_logic_0: component Custom_TrafGen_util_reduced_logic_0_0
     port map (
      Op1(30 downto 0) => util_vector_logic_0_Res(30 downto 0),
      Res => util_reduced_logic_0_Res
    );
util_reduced_logic_1: component Custom_TrafGen_util_reduced_logic_1_0
     port map (
      Op1(30 downto 0) => xlslice_0_Dout(30 downto 0),
      Res => util_reduced_logic_1_Res
    );
util_vector_logic_0: component Custom_TrafGen_util_vector_logic_0_0
     port map (
      Op1(30 downto 0) => c_counter_binary_0_Q(30 downto 0),
      Op2(30 downto 0) => xlslice_0_Dout(30 downto 0),
      Res(30 downto 0) => util_vector_logic_0_Res(30 downto 0)
    );
util_vector_logic_1: component Custom_TrafGen_util_vector_logic_1_0
     port map (
      Op1(0) => util_vector_logic_2_Res(0),
      Op2(0) => axis_register_slice_0_s_axis_tready,
      Res(0) => util_vector_logic_1_Res(0)
    );
util_vector_logic_2: component Custom_TrafGen_util_vector_logic_2_0
     port map (
      Op1(0) => util_reduced_logic_0_Res,
      Res(0) => util_vector_logic_2_Res(0)
    );
util_vector_logic_3: component Custom_TrafGen_util_vector_logic_3_0
     port map (
      Op1(0) => c_counter_binary_1_Q(0),
      Res(0) => util_vector_logic_3_Res(0)
    );
util_vector_logic_4: component Custom_TrafGen_util_vector_logic_4_0
     port map (
      Op1(0) => util_vector_logic_3_Res(0),
      Op2(0) => util_reduced_logic_1_Res,
      Res(0) => util_vector_logic_4_Res(0)
    );
xlconstant_2: component Custom_TrafGen_xlconstant_2_0
     port map (
      dout(63 downto 0) => xlconstant_2_dout(63 downto 0)
    );
xlconstant_3: component Custom_TrafGen_xlconstant_3_0
     port map (
      dout(7 downto 0) => xlconstant_3_dout(7 downto 0)
    );
xlslice_0: component Custom_TrafGen_xlslice_0_0
     port map (
      Din(31 downto 0) => Op2_1(31 downto 0),
      Dout(30 downto 0) => xlslice_0_Dout(30 downto 0)
    );
xlslice_1: component Custom_TrafGen_xlslice_1_0
     port map (
      Din(31 downto 0) => Op2_1(31 downto 0),
      Dout(0) => xlslice_1_Dout(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Custom_TrafGen is
  port (
    M_AXIS_0_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXIS_0_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_0_tlast : out STD_LOGIC;
    M_AXIS_0_tready : in STD_LOGIC;
    M_AXIS_0_tvalid : out STD_LOGIC;
    Op2_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of Custom_TrafGen : entity is "Custom_TrafGen,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Custom_TrafGen,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=15,numReposBlks=14,numNonXlnxBlks=0,numHierBlks=1,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of Custom_TrafGen : entity is "Custom_TrafGen.hwdef";
end Custom_TrafGen;

architecture STRUCTURE of Custom_TrafGen is
  signal Op2_0_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal trafgen_custom_M_AXIS_TDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal trafgen_custom_M_AXIS_TKEEP : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal trafgen_custom_M_AXIS_TLAST : STD_LOGIC;
  signal trafgen_custom_M_AXIS_TREADY : STD_LOGIC;
  signal trafgen_custom_M_AXIS_TVALID : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of M_AXIS_0_tlast : signal is "xilinx.com:interface:axis:1.0 M_AXIS_0 TLAST";
  attribute X_INTERFACE_INFO of M_AXIS_0_tready : signal is "xilinx.com:interface:axis:1.0 M_AXIS_0 TREADY";
  attribute X_INTERFACE_INFO of M_AXIS_0_tvalid : signal is "xilinx.com:interface:axis:1.0 M_AXIS_0 TVALID";
  attribute X_INTERFACE_INFO of ap_clk : signal is "xilinx.com:signal:clock:1.0 CLK.AP_CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ap_clk : signal is "XIL_INTERFACENAME CLK.AP_CLK, ASSOCIATED_BUSIF M_AXIS_0, ASSOCIATED_RESET ap_rst_n, CLK_DOMAIN Custom_TrafGen_ap_clk, FREQ_HZ 250000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of ap_rst_n : signal is "xilinx.com:signal:reset:1.0 RST.AP_RST_N RST";
  attribute X_INTERFACE_PARAMETER of ap_rst_n : signal is "XIL_INTERFACENAME RST.AP_RST_N, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of M_AXIS_0_tdata : signal is "xilinx.com:interface:axis:1.0 M_AXIS_0 TDATA";
  attribute X_INTERFACE_PARAMETER of M_AXIS_0_tdata : signal is "XIL_INTERFACENAME M_AXIS_0, CLK_DOMAIN Custom_TrafGen_ap_clk, FREQ_HZ 250000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.000, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0";
  attribute X_INTERFACE_INFO of M_AXIS_0_tkeep : signal is "xilinx.com:interface:axis:1.0 M_AXIS_0 TKEEP";
begin
  M_AXIS_0_tdata(63 downto 0) <= trafgen_custom_M_AXIS_TDATA(63 downto 0);
  M_AXIS_0_tkeep(7 downto 0) <= trafgen_custom_M_AXIS_TKEEP(7 downto 0);
  M_AXIS_0_tlast <= trafgen_custom_M_AXIS_TLAST;
  M_AXIS_0_tvalid <= trafgen_custom_M_AXIS_TVALID;
  Op2_0_1(31 downto 0) <= Op2_0(31 downto 0);
  trafgen_custom_M_AXIS_TREADY <= M_AXIS_0_tready;
trafgen_custom: entity work.trafgen_custom_imp_2A8DKV
     port map (
      M_AXIS_tdata(63 downto 0) => trafgen_custom_M_AXIS_TDATA(63 downto 0),
      M_AXIS_tkeep(7 downto 0) => trafgen_custom_M_AXIS_TKEEP(7 downto 0),
      M_AXIS_tlast => trafgen_custom_M_AXIS_TLAST,
      M_AXIS_tready => trafgen_custom_M_AXIS_TREADY,
      M_AXIS_tvalid => trafgen_custom_M_AXIS_TVALID,
      Op2(31 downto 0) => Op2_0_1(31 downto 0),
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n
    );
end STRUCTURE;
