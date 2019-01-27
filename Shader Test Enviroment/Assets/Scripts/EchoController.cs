using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EchoController : MonoBehaviour {

	public List<Transform> objPositions = new List<Transform>();
	private List<Vector4> vectorPos = new List<Vector4>();
	public Material renderShader;
	public List<PulseData> checkState = new List<PulseData>();
	private List<float> soundWaves = new List<float>();
    private List<float> ringSizes = new List<float>();
	private List<float> maxPulseDist = new List<float>();

	void Start()
	{
        for (int i = 0; i < objPositions.Count; i++)
        {
            vectorPos.Add(objPositions[i].position);
			soundWaves.Add(checkState[i].soundPulse);
			ringSizes.Add(checkState[i].currentRingSize);
            maxPulseDist.Add(checkState[i].maxDistance);
        }
	}

	void UpdateList(int i)
	{
		vectorPos[i] = objPositions[i].position;
	}

	void Update()
	{
		for(int i = 0; i < checkState.Count; i++){
			if(!checkState[i].isTraveling){
				UpdateList(i);
			}
        	soundWaves[i] = checkState[i].soundPulse;
        	ringSizes[i] = checkState[i].currentRingSize;
            maxPulseDist[i] = checkState[i].maxDistance;
		}
			renderShader.SetVectorArray("_ObjectPositions", vectorPos);
        	renderShader.SetInt("_ArrayLenght", vectorPos.Count);
            renderShader.SetFloatArray("_SoundWave", soundWaves);
            renderShader.SetFloatArray("_RingSize", ringSizes);
        	renderShader.SetFloatArray("_MaxDistance", maxPulseDist);
	}

}
