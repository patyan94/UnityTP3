using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class Checkpoint : MonoBehaviour 
{
	[SerializeField]
	private CheckpointManager _manager;

	[SerializeField]
	private int _index;
	

	void OnTriggerEnter(Collider other)
	{
		if (other as WheelCollider == null)
		{
			CarController car = other.transform.GetComponentInParent<CarController>();
			if (car)
			{
				_manager.CheckpointTriggered(car,_index);
				car.SendMessage("enableTurnTips",_index,SendMessageOptions.DontRequireReceiver);
			}
		}

	}

	void OnTriggerExit(Collider other){

		if (other as WheelCollider == null)
		{
			CarController car = other.transform.GetComponentInParent<CarController>();
			if (car)
			{
				car.SendMessage("disableTurnTips",false,SendMessageOptions.DontRequireReceiver);
			}
		}
	}



}
