using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using System.Collections;

public class CheckpointManager : MonoBehaviour 
{

	[SerializeField]
	private GameObject _carContainer;

	[SerializeField]
	private int _checkPointCount;
	[SerializeField]
	private int _totalLaps;

	private bool _finished = false;
	private bool _carsSorted = false;
	
	private Dictionary<CarController,PositionData> _carPositions = new Dictionary<CarController, PositionData>();
	List<KeyValuePair<CarController, PositionData>> _carPosLit;

	private class PositionData
	{
		public int lap;
		public int checkPoint;
		public Vector3 position;
		public int checkPointCount = 0;
		public bool startCouting = false;
	}

	private class CustomComparer : IComparer<KeyValuePair<CarController, PositionData>> {
		public int Compare(KeyValuePair<CarController, PositionData> car1, KeyValuePair<CarController, PositionData> car2)
		{
			//float deltacheckPointCount = Mathf.Sign(car2.Value.checkPointCount - car1.Value.checkPointCount);
			//return (int)deltacheckPointCount;

			if (car1.Value.checkPointCount < car2.Value.checkPointCount)
				return 1;
			else if (car1.Value.checkPointCount > car2.Value.checkPointCount)
				return -1;
			return 0;
		}
	}

	// Use this for initialization
	void Awake () 
	{
		CarController[] cars = _carContainer.GetComponentsInChildren<CarController> (true);
		foreach (CarController car in cars)
		{
			_carPositions[car] = new PositionData();
		}
		_carPosLit = _carPositions.ToList<KeyValuePair<CarController, PositionData>>();

		InvokeRepeating("getRaceRanking",1.0f,2.0f);
	}

	public void getRaceRanking(){

		_carPosLit = _carPositions.ToList<KeyValuePair<CarController, PositionData>>();
		_carPosLit.Sort(new CustomComparer());
		_carsSorted = true;


		int rank = 1;
		foreach(KeyValuePair<CarController, PositionData> car in _carPosLit){
			string log = rank.ToString() +  car.Key.ToString() + car.Value.checkPointCount.ToString();
			//Debug.Log(log);
			rank++;
		}
		rank = 1;

		////Debug.Log (getFirstCar ().ToString ());
	}

	public CarController getFirstCar(){
		return _carPosLit.First ().Key;
	}

	public CarController getLastCar(){
		return _carPosLit.Last ().Key;
	}

	public CarController getNext(CarController car){

		CarController itemToReturn = null;

		PositionData carPosData = null;
		carPosData = _carPositions[car];
		if (carPosData == null)
			return null;

		KeyValuePair<CarController, PositionData> temp = new KeyValuePair<CarController, PositionData> (car, carPosData);
		int index = _carPosLit.BinarySearch (temp,new CustomComparer());

		index--;
		if(index >= 0)
			itemToReturn = _carPosLit.ElementAt(index).Key;

		for (; index > 0 && index < _carPosLit.Count(); index--) {
			if(_carPosLit.ElementAt(index).Key && _carPosLit.ElementAt(index).Key.gameObject.activeSelf)
				return _carPosLit.ElementAt(index).Key;;
		}

		return itemToReturn;
	}
	
	public void CheckpointTriggered(CarController car, int checkPointIndex)
	{

		PositionData carData = _carPositions[car];
		carData.position = car.transform.position;

		if (!_finished)
		{
			if (checkPointIndex == 0)
			{
				carData.startCouting = true;
				carData.checkPointCount++;

				if (carData.checkPoint == _checkPointCount-1)
				{
					carData.checkPoint = checkPointIndex;
					carData.lap += 1;
					//Debug.Log(car.name + " lap " + carData.lap);
					if (IsPlayer(car))
					{
						GetComponent<RaceManager>().Announce("Tour " + (carData.lap+1).ToString());
					}

					if (carData.lap >= _totalLaps)
					{
						_finished = true;
						GetComponent<RaceManager>().EndRace(car.name.ToLower());
					}
				}
			}
			else if (carData.checkPoint == checkPointIndex-1) //Checkpoints must be hit in order
			{
				carData.checkPoint = checkPointIndex;
				if(carData.startCouting)
					carData.checkPointCount++;
			}
		}


	}

	bool IsPlayer(CarController car)
	{
		return car.GetComponent<CarUserControlMP>() != null;
	}
}
