Shader "Custom/MyShader"
{
    //属性块
    Properties{
        //显示Material 上的属性 
        // - texture
        //属性的语法格式 属性的变量名(属性的显示名字，属性的类型) —— 属性的初始值
        //属性的变量名是在Shader中使用的名称
        //属性的显示名称 是在材质面板里显示的名称
        //属性的类型 大小写 无关
        _MainTex("My texture",2D) = "white"{}
        _MyTexture2("My texture2",2D) = "bump"{}

        _MyInt("My integer", int) = 2
        _MyRange("My Range", range(0.0,1.0)) = 0.5
        _MyColor("MyColor", Color) = (1,0,0,1) //color 范围在 0- 1
        _MyVector("MyVector", Vector) =(1,1,1,1)
        // - colours
        // - parameters
            }
    
    //可以编写多个SubShader Unity会按顺序去执行
    SubShader 
    { 
        
        //Shader程序区分大小写
        //此处编写 Shader代码
        //Surface Shader 
        //Or 
        //VS FS
        //Or
        //fixed function shader
        Tags  // Unity3D 特定的属性
        {
            
        }
        
        CGPROGRAM
        //Shader代码 写在这之间
        // Uses the Labertian lighting model
        #pragma surface surf Lambert  //因为是表面着色器，所有主贴图的名字必须是 _MainTex, 采样的名字也要是_MainTex

        // The input texture
        //无法直接使用Texture，需要对Texture进行纹理采样
        //如果想要使用上面的属性 必须要在下面声明相应的变量  名字要相同
        sampler2D _MainTex; // Sampler2D 是Texture2D
        int _MyInt;
        float4 _MyVector; //float4 是 向量
        half _MyRange;
        half4 _MyColor;//颜色通常用 half4  16位的浮点数 内存
        struct Input {
            float2 uv_MainTex;
        };

          
        void surf (Input IN, inout SurfaceOutput o) //此函数被Unity调用  并传入相应参数
        {
            //o.Albedo = float4 (1,0,0,1);
            o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb * _MyColor.rgb;

        }
        ENDCG
    }    
}
