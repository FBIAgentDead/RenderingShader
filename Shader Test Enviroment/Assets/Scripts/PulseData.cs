using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PulseData : MonoBehaviour {

	public KeyCode thisInput;
    [System.NonSerialized]
	public Transform characterPos;
	public float startRingSize;
    [System.NonSerialized]
	public float soundPulse;
	public float pulseSpeed;
	public float pulseRange;
    [System.NonSerialized]
	public bool isTraveling;
    [System.NonSerialized]
	public float currentRingSize;
    [System.NonSerialized]
	public float maxDistance;

	void Start()
	{
		characterPos = gameObject.GetComponent<Transform>();
	}

	void Update()
	{
		if(Input.GetKeyDown(thisInput) && !isTraveling){
			StartCoroutine(SoundTravel(pulseRange));
		}
	}

	private IEnumerator SoundTravel(float maxPulse){
		isTraveling = true;
		currentRingSize = startRingSize;
		while(soundPulse < maxPulse){
			soundPulse += 0.25f;
			currentRingSize -= (startRingSize/(maxPulse/0.25f));
			maxDistance = maxPulse;
			yield return new WaitForSeconds(pulseSpeed/10);
		}
		currentRingSize = 0;
		soundPulse = 0;
        isTraveling = false;
	}

}
