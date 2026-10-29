using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PortralControl : MonoBehaviour
{
    public float circleClipStart;
    public float featherStart;
    public float ringWidthStart;
    public float portalSpeed;

    private float circleClipTarget;
    private float featherTarget;
    private float ringwidthTarget;

    private float circleClipCurrent;
    private float featherCurrent;
    private float ringwidthCurrent;

    private Material mat;

    // Start is called before the first frame update
    void Start()
    {
        mat = GetComponent<MeshRenderer>().material;
    }

    // Update is called once per frame
    void Update()
    {
        circleClipCurrent = Mathf.Lerp(circleClipCurrent, circleClipTarget, Time.deltaTime * portalSpeed);
        featherCurrent = Mathf.Lerp(featherCurrent, featherTarget, Time.deltaTime * portalSpeed);
        ringwidthCurrent = Mathf.Lerp(ringwidthCurrent, ringwidthTarget, Time.deltaTime * portalSpeed);

        if(Input.GetKeyDown(KeyCode.A))
        {
            circleClipTarget = circleClipStart;
            featherTarget = featherStart;
            ringwidthTarget = ringWidthStart;
        }

        if (Input.GetKeyDown(KeyCode.S))
        {
            circleClipTarget = 0;
            featherTarget = 0;
            ringwidthTarget = 0;
        }

        mat.SetFloat("_CircleClip", circleClipCurrent);
        mat.SetFloat("_Feather", featherCurrent);
        mat.SetFloat("_RingWidth", ringwidthCurrent);


    }
}
