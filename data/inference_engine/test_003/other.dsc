<?xml version="1.0" ?>
<net batch="1" name="cnn_fd_004_sq_light_ssd" version="4">
	<layers>
		<layer id="0" name="data" precision="FP32" type="Input">
			<output>
				<port id="0">
					<dim>1</dim>
					<dim>3</dim>
					<dim>300</dim>
					<dim>300</dim>
				</port>
			</output>
		</layer>
		<layer id="1" name="Scale1/Mul_/FusedScaleShift_" precision="FP32" type="ScaleShift">
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>3</dim>
					<dim>300</dim>
					<dim>300</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>3</dim>
					<dim>300</dim>
					<dim>300</dim>
				</port>
			</output>
			<blobs>
				<weights offset="0" size="12"/>
				<biases offset="12" size="12"/>
			</blobs>
		</layer>
		<layer id="2" name="Convolution1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="7,7" output="32" pads_begin="3,3" pads_end="3,3" strides="2,2"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>3</dim>
					<dim>300</dim>
					<dim>300</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>32</dim>
					<dim>150</dim>
					<dim>150</dim>
				</port>
			</output>
			<blobs>
				<weights offset="24" size="18816"/>
				<biases offset="18840" size="128"/>
			</blobs>
		</layer>
		<layer id="3" name="ReLU1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>150</dim>
					<dim>150</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>150</dim>
					<dim>150</dim>
				</port>
			</output>
		</layer>
		<layer id="4" name="Pooling1" precision="FP32" type="Pooling">
			<data exclude-pad="true" kernel="3,3" pads_begin="0,0" pads_end="0,0" pool-method="max" rounding_type="ceil" strides="2,2"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>150</dim>
					<dim>150</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="5" name="fire2/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="8" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="18968" size="1024"/>
				<biases offset="19992" size="32"/>
			</blobs>
		</layer>
		<layer id="6" name="fire2/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="7" name="fire2/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="32" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="20024" size="9216"/>
				<biases offset="29240" size="128"/>
			</blobs>
		</layer>
		<layer id="8" name="fire2/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="9" name="fire2/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="32" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="29368" size="1024"/>
				<biases offset="30392" size="128"/>
			</blobs>
		</layer>
		<layer id="10" name="fire2/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="11" name="Concat1" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="12" name="fire3/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="8" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="30520" size="2048"/>
				<biases offset="32568" size="32"/>
			</blobs>
		</layer>
		<layer id="13" name="fire3/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="14" name="fire3/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="32" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="32600" size="9216"/>
				<biases offset="41816" size="128"/>
			</blobs>
		</layer>
		<layer id="15" name="fire3/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="16" name="fire3/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="32" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>8</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="41944" size="1024"/>
				<biases offset="42968" size="128"/>
			</blobs>
		</layer>
		<layer id="17" name="fire3/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="18" name="Concat2" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="19" name="fire4/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="16" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>16</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="43096" size="4096"/>
				<biases offset="47192" size="64"/>
			</blobs>
		</layer>
		<layer id="20" name="fire4/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>16</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>16</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="21" name="fire4/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="64" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>16</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="47256" size="36864"/>
				<biases offset="84120" size="256"/>
			</blobs>
		</layer>
		<layer id="22" name="fire4/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="23" name="fire4/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="64" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>16</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
			<blobs>
				<weights offset="84376" size="4096"/>
				<biases offset="88472" size="256"/>
			</blobs>
		</layer>
		<layer id="24" name="fire4/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="25" name="Concat3" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>64</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>128</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</output>
		</layer>
		<layer id="26" name="fire5/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="16" pads_begin="0,0" pads_end="0,0" strides="2,2"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>128</dim>
					<dim>75</dim>
					<dim>75</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>16</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="88728" size="8192"/>
				<biases offset="96920" size="64"/>
			</blobs>
		</layer>
		<layer id="27" name="fire5/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>16</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>16</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="28" name="fire5/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="64" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>16</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>64</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="96984" size="36864"/>
				<biases offset="133848" size="256"/>
			</blobs>
		</layer>
		<layer id="29" name="fire5/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>64</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>64</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="30" name="fire5/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="64" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>16</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>64</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="134104" size="4096"/>
				<biases offset="138200" size="256"/>
			</blobs>
		</layer>
		<layer id="31" name="fire5/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>64</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>64</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="32" name="Concat4" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>64</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>64</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="33" name="fire6/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="24" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="138456" size="12288"/>
				<biases offset="150744" size="96"/>
			</blobs>
		</layer>
		<layer id="34" name="fire6/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="35" name="fire6/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="96" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="150840" size="82944"/>
				<biases offset="233784" size="384"/>
			</blobs>
		</layer>
		<layer id="36" name="fire6/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="37" name="fire6/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="96" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="234168" size="9216"/>
				<biases offset="243384" size="384"/>
			</blobs>
		</layer>
		<layer id="38" name="fire6/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="39" name="Concat5" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>192</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="40" name="fire7/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="24" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>192</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="243768" size="18432"/>
				<biases offset="262200" size="96"/>
			</blobs>
		</layer>
		<layer id="41" name="fire7/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="42" name="fire7/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="96" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="262296" size="82944"/>
				<biases offset="345240" size="384"/>
			</blobs>
		</layer>
		<layer id="43" name="fire7/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="44" name="fire7/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="96" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>24</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="345624" size="9216"/>
				<biases offset="354840" size="384"/>
			</blobs>
		</layer>
		<layer id="45" name="fire7/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="46" name="Concat6" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>96</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>192</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="47" name="fire8/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="32" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>192</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>32</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="355224" size="24576"/>
				<biases offset="379800" size="128"/>
			</blobs>
		</layer>
		<layer id="48" name="fire8/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="49" name="fire8/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="128" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="379928" size="147456"/>
				<biases offset="527384" size="512"/>
			</blobs>
		</layer>
		<layer id="50" name="fire8/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="51" name="fire8/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="128" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
			<blobs>
				<weights offset="527896" size="16384"/>
				<biases offset="544280" size="512"/>
			</blobs>
		</layer>
		<layer id="52" name="fire8/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="53" name="Concat7" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>128</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>256</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</output>
		</layer>
		<layer id="54" name="fire9/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="32" pads_begin="0,0" pads_end="0,0" strides="2,2"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>256</dim>
					<dim>38</dim>
					<dim>38</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>32</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="544792" size="32768"/>
				<biases offset="577560" size="128"/>
			</blobs>
		</layer>
		<layer id="55" name="fire9/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>32</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="56" name="fire9/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="128" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>128</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="577688" size="147456"/>
				<biases offset="725144" size="512"/>
			</blobs>
		</layer>
		<layer id="57" name="fire9/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>128</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>128</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="58" name="fire9/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="128" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>32</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>128</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="725656" size="16384"/>
				<biases offset="742040" size="512"/>
			</blobs>
		</layer>
		<layer id="59" name="fire9/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>128</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>128</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="60" name="Concat8" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>128</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>128</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>256</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="61" name="fire10/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="48" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>256</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="742552" size="49152"/>
				<biases offset="791704" size="192"/>
			</blobs>
		</layer>
		<layer id="62" name="fire10/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="63" name="fire10/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="192" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="791896" size="331776"/>
				<biases offset="1123672" size="768"/>
			</blobs>
		</layer>
		<layer id="64" name="fire10/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="65" name="fire10/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="192" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="1124440" size="36864"/>
				<biases offset="1161304" size="768"/>
			</blobs>
		</layer>
		<layer id="66" name="fire10/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="67" name="Concat9" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>384</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="68" name="fire11/squeeze1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="48" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>384</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="1162072" size="73728"/>
				<biases offset="1235800" size="192"/>
			</blobs>
		</layer>
		<layer id="69" name="fire11/relu_squeeze1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="70" name="fire11/expand3x3" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="192" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="1235992" size="331776"/>
				<biases offset="1567768" size="768"/>
			</blobs>
		</layer>
		<layer id="71" name="fire11/relu_expand3x3" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="72" name="fire11/expand1x1" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="1,1" output="192" pads_begin="0,0" pads_end="0,0" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>48</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="1568536" size="36864"/>
				<biases offset="1605400" size="768"/>
			</blobs>
		</layer>
		<layer id="73" name="fire11/relu_expand1x1" precision="FP32" type="ReLU">
			<data negative_slope="0.0"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="74" name="Concat10" precision="FP32" type="Concat">
			<data axis="1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>192</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>384</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
		</layer>
		<layer id="75" name="fc7_mbox_loc" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="36" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>384</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>36</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="1606168" size="497664"/>
				<biases offset="2103832" size="144"/>
			</blobs>
		</layer>
		<layer id="76" name="fc7_mbox_loc_perm" precision="FP32" type="Permute">
			<data order="0,2,3,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>36</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>19</dim>
					<dim>19</dim>
					<dim>36</dim>
				</port>
			</output>
		</layer>
		<layer id="77" name="fc7_mbox_loc_flat" precision="FP32" type="Flatten">
			<data axis="1" end_axis="-1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>19</dim>
					<dim>19</dim>
					<dim>36</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>12996</dim>
				</port>
			</output>
		</layer>
		<layer id="78" name="fc7_mbox_conf" precision="FP32" type="Convolution">
			<data dilations="1,1" group="1" kernel="3,3" output="18" pads_begin="1,1" pads_end="1,1" strides="1,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>384</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>18</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</output>
			<blobs>
				<weights offset="2103976" size="248832"/>
				<biases offset="2352808" size="72"/>
			</blobs>
		</layer>
		<layer id="79" name="fc7_mbox_conf_perm" precision="FP32" type="Permute">
			<data order="0,2,3,1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>18</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>19</dim>
					<dim>19</dim>
					<dim>18</dim>
				</port>
			</output>
		</layer>
		<layer id="80" name="fc7_mbox_conf_flat" precision="FP32" type="Flatten">
			<data axis="1" end_axis="-1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>19</dim>
					<dim>19</dim>
					<dim>18</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>6498</dim>
				</port>
			</output>
		</layer>
		<layer id="81" name="mbox_conf_reshape/DimData_const" precision="FP32" type="Const">
			<output>
				<port id="1">
					<dim>3</dim>
				</port>
			</output>
			<blobs>
				<custom offset="2352880" size="12"/>
			</blobs>
		</layer>
		<layer id="82" name="mbox_conf_reshape" precision="FP32" type="Reshape">
			<data axis="0" num_axes="-1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>6498</dim>
				</port>
				<port id="1">
					<dim>3</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>3249</dim>
					<dim>2</dim>
				</port>
			</output>
		</layer>
		<layer id="83" name="mbox_conf_softmax" precision="FP32" type="SoftMax">
			<data axis="2"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>3249</dim>
					<dim>2</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>3249</dim>
					<dim>2</dim>
				</port>
			</output>
		</layer>
		<layer id="84" name="mbox_conf_flatten" precision="FP32" type="Flatten">
			<data axis="1" end_axis="-1"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>3249</dim>
					<dim>2</dim>
				</port>
			</input>
			<output>
				<port id="1">
					<dim>1</dim>
					<dim>6498</dim>
				</port>
			</output>
		</layer>
		<layer id="85" name="fc7_mbox_priorbox" precision="FP32" type="PriorBoxClustered">
			<data clip="0" flip="1" height="15.0,39.599998474121094,25.5,63.20000076293945,227.5,162.89999389648438,124.5,105.0999984741211,72.5999984741211" offset="0.5" step="16.0" variance="0.10000000149011612,0.10000000149011612,0.20000000298023224,0.20000000298023224" width="9.399999618530273,25.100000381469727,14.699999809265137,34.70000076293945,143.0,77.4000015258789,128.8000030517578,51.099998474121094,75.5999984741211"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>384</dim>
					<dim>19</dim>
					<dim>19</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>3</dim>
					<dim>300</dim>
					<dim>300</dim>
				</port>
			</input>
			<output>
				<port id="2">
					<dim>1</dim>
					<dim>2</dim>
					<dim>12996</dim>
				</port>
			</output>
		</layer>
		<layer id="86" name="detection_out" precision="FP32" type="DetectionOutput">
			<data background_label_id="0" code_type="caffe.PriorBoxParameter.CENTER_SIZE" confidence_threshold="0.009999999776482582" eta="1.0" input_height="1" input_width="1" keep_top_k="200" nms_threshold="0.44999998807907104" normalized="1" num_classes="2" share_location="1" top_k="400" variance_encoded_in_target="0" visualize="False"/>
			<input>
				<port id="0">
					<dim>1</dim>
					<dim>12996</dim>
				</port>
				<port id="1">
					<dim>1</dim>
					<dim>6498</dim>
				</port>
				<port id="2">
					<dim>1</dim>
					<dim>2</dim>
					<dim>12996</dim>
				</port>
			</input>
			<output>
				<port id="3">
					<dim>1</dim>
					<dim>1</dim>
					<dim>200</dim>
					<dim>7</dim>
				</port>
			</output>
		</layer>
	</layers>
	<edges>
		<edge from-layer="0" from-port="0" to-layer="1" to-port="0"/>
		<edge from-layer="1" from-port="3" to-layer="2" to-port="0"/>
		<edge from-layer="2" from-port="3" to-layer="3" to-port="0"/>
		<edge from-layer="3" from-port="1" to-layer="4" to-port="0"/>
		<edge from-layer="4" from-port="1" to-layer="5" to-port="0"/>
		<edge from-layer="5" from-port="3" to-layer="6" to-port="0"/>
		<edge from-layer="6" from-port="1" to-layer="7" to-port="0"/>
		<edge from-layer="7" from-port="3" to-layer="8" to-port="0"/>
		<edge from-layer="6" from-port="1" to-layer="9" to-port="0"/>
		<edge from-layer="9" from-port="3" to-layer="10" to-port="0"/>
		<edge from-layer="8" from-port="1" to-layer="11" to-port="0"/>
		<edge from-layer="10" from-port="1" to-layer="11" to-port="1"/>
		<edge from-layer="11" from-port="2" to-layer="12" to-port="0"/>
		<edge from-layer="12" from-port="3" to-layer="13" to-port="0"/>
		<edge from-layer="13" from-port="1" to-layer="14" to-port="0"/>
		<edge from-layer="14" from-port="3" to-layer="15" to-port="0"/>
		<edge from-layer="13" from-port="1" to-layer="16" to-port="0"/>
		<edge from-layer="16" from-port="3" to-layer="17" to-port="0"/>
		<edge from-layer="15" from-port="1" to-layer="18" to-port="0"/>
		<edge from-layer="17" from-port="1" to-layer="18" to-port="1"/>
		<edge from-layer="18" from-port="2" to-layer="19" to-port="0"/>
		<edge from-layer="19" from-port="3" to-layer="20" to-port="0"/>
		<edge from-layer="20" from-port="1" to-layer="21" to-port="0"/>
		<edge from-layer="21" from-port="3" to-layer="22" to-port="0"/>
		<edge from-layer="20" from-port="1" to-layer="23" to-port="0"/>
		<edge from-layer="23" from-port="3" to-layer="24" to-port="0"/>
		<edge from-layer="22" from-port="1" to-layer="25" to-port="0"/>
		<edge from-layer="24" from-port="1" to-layer="25" to-port="1"/>
		<edge from-layer="25" from-port="2" to-layer="26" to-port="0"/>
		<edge from-layer="26" from-port="3" to-layer="27" to-port="0"/>
		<edge from-layer="27" from-port="1" to-layer="28" to-port="0"/>
		<edge from-layer="28" from-port="3" to-layer="29" to-port="0"/>
		<edge from-layer="27" from-port="1" to-layer="30" to-port="0"/>
		<edge from-layer="30" from-port="3" to-layer="31" to-port="0"/>
		<edge from-layer="29" from-port="1" to-layer="32" to-port="0"/>
		<edge from-layer="31" from-port="1" to-layer="32" to-port="1"/>
		<edge from-layer="32" from-port="2" to-layer="33" to-port="0"/>
		<edge from-layer="33" from-port="3" to-layer="34" to-port="0"/>
		<edge from-layer="34" from-port="1" to-layer="35" to-port="0"/>
		<edge from-layer="35" from-port="3" to-layer="36" to-port="0"/>
		<edge from-layer="34" from-port="1" to-layer="37" to-port="0"/>
		<edge from-layer="37" from-port="3" to-layer="38" to-port="0"/>
		<edge from-layer="36" from-port="1" to-layer="39" to-port="0"/>
		<edge from-layer="38" from-port="1" to-layer="39" to-port="1"/>
		<edge from-layer="39" from-port="2" to-layer="40" to-port="0"/>
		<edge from-layer="40" from-port="3" to-layer="41" to-port="0"/>
		<edge from-layer="41" from-port="1" to-layer="42" to-port="0"/>
		<edge from-layer="42" from-port="3" to-layer="43" to-port="0"/>
		<edge from-layer="41" from-port="1" to-layer="44" to-port="0"/>
		<edge from-layer="44" from-port="3" to-layer="45" to-port="0"/>
		<edge from-layer="43" from-port="1" to-layer="46" to-port="0"/>
		<edge from-layer="45" from-port="1" to-layer="46" to-port="1"/>
		<edge from-layer="46" from-port="2" to-layer="47" to-port="0"/>
		<edge from-layer="47" from-port="3" to-layer="48" to-port="0"/>
		<edge from-layer="48" from-port="1" to-layer="49" to-port="0"/>
		<edge from-layer="49" from-port="3" to-layer="50" to-port="0"/>
		<edge from-layer="48" from-port="1" to-layer="51" to-port="0"/>
		<edge from-layer="51" from-port="3" to-layer="52" to-port="0"/>
		<edge from-layer="50" from-port="1" to-layer="53" to-port="0"/>
		<edge from-layer="52" from-port="1" to-layer="53" to-port="1"/>
		<edge from-layer="53" from-port="2" to-layer="54" to-port="0"/>
		<edge from-layer="54" from-port="3" to-layer="55" to-port="0"/>
		<edge from-layer="55" from-port="1" to-layer="56" to-port="0"/>
		<edge from-layer="56" from-port="3" to-layer="57" to-port="0"/>
		<edge from-layer="55" from-port="1" to-layer="58" to-port="0"/>
		<edge from-layer="58" from-port="3" to-layer="59" to-port="0"/>
		<edge from-layer="57" from-port="1" to-layer="60" to-port="0"/>
		<edge from-layer="59" from-port="1" to-layer="60" to-port="1"/>
		<edge from-layer="60" from-port="2" to-layer="61" to-port="0"/>
		<edge from-layer="61" from-port="3" to-layer="62" to-port="0"/>
		<edge from-layer="62" from-port="1" to-layer="63" to-port="0"/>
		<edge from-layer="63" from-port="3" to-layer="64" to-port="0"/>
		<edge from-layer="62" from-port="1" to-layer="65" to-port="0"/>
		<edge from-layer="65" from-port="3" to-layer="66" to-port="0"/>
		<edge from-layer="64" from-port="1" to-layer="67" to-port="0"/>
		<edge from-layer="66" from-port="1" to-layer="67" to-port="1"/>
		<edge from-layer="67" from-port="2" to-layer="68" to-port="0"/>
		<edge from-layer="68" from-port="3" to-layer="69" to-port="0"/>
		<edge from-layer="69" from-port="1" to-layer="70" to-port="0"/>
		<edge from-layer="70" from-port="3" to-layer="71" to-port="0"/>
		<edge from-layer="69" from-port="1" to-layer="72" to-port="0"/>
		<edge from-layer="72" from-port="3" to-layer="73" to-port="0"/>
		<edge from-layer="71" from-port="1" to-layer="74" to-port="0"/>
		<edge from-layer="73" from-port="1" to-layer="74" to-port="1"/>
		<edge from-layer="74" from-port="2" to-layer="75" to-port="0"/>
		<edge from-layer="75" from-port="3" to-layer="76" to-port="0"/>
		<edge from-layer="76" from-port="1" to-layer="77" to-port="0"/>
		<edge from-layer="74" from-port="2" to-layer="78" to-port="0"/>
		<edge from-layer="78" from-port="3" to-layer="79" to-port="0"/>
		<edge from-layer="79" from-port="1" to-layer="80" to-port="0"/>
		<edge from-layer="80" from-port="1" to-layer="82" to-port="0"/>
		<edge from-layer="81" from-port="1" to-layer="82" to-port="1"/>
		<edge from-layer="82" from-port="2" to-layer="83" to-port="0"/>
		<edge from-layer="83" from-port="1" to-layer="84" to-port="0"/>
		<edge from-layer="74" from-port="2" to-layer="85" to-port="0"/>
		<edge from-layer="1" from-port="3" to-layer="85" to-port="1"/>
		<edge from-layer="77" from-port="1" to-layer="86" to-port="0"/>
		<edge from-layer="84" from-port="1" to-layer="86" to-port="1"/>
		<edge from-layer="85" from-port="2" to-layer="86" to-port="2"/>
	</edges>
	<meta_data>
		<MO_version value="2019.1.0-178-ga427cda"/>
		<cli_parameters>
			<data_type value="FP32"/>
			<disable_fusing value="False"/>
			<disable_gfusing value="False"/>
			<disable_nhwc_to_nchw value="False"/>
			<disable_omitting_optional value="False"/>
			<disable_resnet_optimization value="False"/>
			<enable_concat_optimization value="False"/>
			<enable_flattening_nested_params value="False"/>
			<extensions value="DIR"/>
			<framework value="caffe"/>
			<generate_deprecated_IR_V2 value="False"/>
			<input value="data"/>
			<input_model value="DIR/cnn_fd_004_sq_light_ssd.caffemodel"/>
			<input_model_is_text value="False"/>
			<input_proto value="DIR/cnn_fd_004_sq_light_ssd.prototxt"/>
			<input_shape value="[1,3,300,300]"/>
			<k value="DIR/CustomLayersMapping.xml"/>
			<keep_shape_ops value="False"/>
			<legacy_mxnet_model value="False"/>
			<log_level value="ERROR"/>
			<mean_scale_values value="{}"/>
			<mean_values value="()"/>
			<model_name value="face-detection-retail-0004"/>
			<move_to_preprocess value="False"/>
			<output value="['detection_out']"/>
			<output_dir value="DIR"/>
			<placeholder_shapes value="{'data': array([  1,   3, 300, 300])}"/>
			<remove_output_softmax value="False"/>
			<reverse_input_channels value="False"/>
			<save_params_from_nd value="False"/>
			<scale_values value="()"/>
			<silent value="False"/>
			<version value="False"/>
			<unset unset_cli_parameters="batch, counts, finegrain_fusing, freeze_placeholder_with_value, input_checkpoint, input_meta_graph, input_symbol, mean_file, mean_file_offsets, nd_prefix_name, pretrained_model_name, saved_model_dir, saved_model_tags, scale, tensorboard_logdir, tensorflow_custom_layer_libraries, tensorflow_custom_operations_config_update, tensorflow_object_detection_api_pipeline_config, tensorflow_operation_patterns, tensorflow_subgraph_patterns, tensorflow_use_custom_operations_config"/>
		</cli_parameters>
	</meta_data>
</net>
