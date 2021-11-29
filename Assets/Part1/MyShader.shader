Shader "Custom/MyShader"
{
    //属性块
    Properties{
    //显示Material 上的属性 
        // - texture
        _MyTexture("My texture",2D) = "white"{}
        
        // - colours
        // - parameters
            }
    
    //可以编写多个SubShader Unity会按顺序去执行
    SubShader{
        //此处编写 Shader代码
        //Surface Shader 
        //Or 
        //VS FS
        //Or
        //fixed function shader
          CGPROGRAM
        // Uses the Labertian lighting model
        #pragma surface surf Lambert

        sampler2D _MainTex;    // The input texture

        struct Input {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = float4 {1,1,1,1};
        }
        ENDCG
    }    
}
