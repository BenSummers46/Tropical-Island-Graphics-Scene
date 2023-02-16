using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class FPSCounter : MonoBehaviour
{
    public float fps;
    public Text fpsText;
    
    // Start is called before the first frame update
    void Start()
    {
        InvokeRepeating("ShowFPS", 1, 1);
    }

    void ShowFPS()
    {
        fps = (int)(1f / Time.unscaledDeltaTime);
        fpsText.text = fps + " fps";
    }
}
