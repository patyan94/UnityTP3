﻿using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using System.Collections;

public class CheckpointManager : MonoBehaviour
{

    [SerializeField]
    private  GameObject _carContainer;


    public static int SNumberOfCheckPoints;
    public static Checkpoint[] SCheckPointList;

    [SerializeField]
    private int _totalLaps;

    private bool _finished = false;

    private Dictionary<CarController, PositionData> _carPositions = new Dictionary<CarController, PositionData>();
    List<KeyValuePair<CarController, PositionData>>  _carPosList;
    public List<Checkpoint> CheckPointList;


    private class PositionData
    {
        public int lap;
        public int lastCheckPoint;
        public int position;
    }

    private class CustomComparer : IComparer<KeyValuePair<CarController, PositionData>>
    {
        public int Compare(KeyValuePair<CarController, PositionData> car1, KeyValuePair<CarController, PositionData> car2)
        {
            //float deltacheckPointCount = Mathf.Sign(car2.Value.checkPointCount - car1.Value.checkPointCount);
            //return (int)deltacheckPointCount;
            int nextcheckPoint1 = (car1.Value.lastCheckPoint + 1) % SNumberOfCheckPoints;
            int nextcheckPoint2 = (car2.Value.lastCheckPoint + 1) %SNumberOfCheckPoints;

            float dist1 = (SCheckPointList[nextcheckPoint1].transform.position - car1.Key.transform.position).magnitude;
            float dist2 = (SCheckPointList[nextcheckPoint2].transform.position - car2.Key.transform.position).magnitude;

            if (car1.Value.lap > car2.Value.lap)
                return -1;
            else if (car1.Value.lap < car2.Value.lap)
                return 1;
            else
            {
                if(car1.Value.lastCheckPoint > car2.Value.lastCheckPoint)
                    return -1;
                if (car1.Value.lastCheckPoint < car2.Value.lastCheckPoint)
                    return 1;
                else
                {
                    if (dist1 < dist2)
                        return -1;
                    else if (dist1 > dist2)
                        return 1;
                    return 0;
                }
            }
        }
    }

    // Use this for initialization
    void Awake()
    {
        SCheckPointList = CheckPointList.ToArray();
        SNumberOfCheckPoints = CheckPointList.Count;
        CarController[] cars = _carContainer.GetComponentsInChildren<CarController>(true);
        foreach (CarController car in cars)
        {
            _carPositions[car] = new PositionData();
        }

        InvokeRepeating("getRaceRanking", 0.0f, 0.01f);
    }

    public void getRaceRanking()
    {

        _carPosList = _carPositions.ToList<KeyValuePair<CarController, PositionData>>();
        _carPosList.Sort(new CustomComparer());
        int i = 1;
        foreach (KeyValuePair<CarController, PositionData> car in _carPosList)
        {
            car.Value.position = i++;
        }
    }

    public CarController getFirstCar()
    {
        getRaceRanking();
        return _carPosList.First().Key;
    }

    public CarController getLastCar()
    {
        getRaceRanking();
        return _carPosList.Last().Key;
    }

    public CarController getNext(CarController car)
    {

        CarController itemToReturn = null;

        PositionData carPosData = null;
        carPosData = _carPositions[car];
        if (carPosData == null || carPosData.position >= _carPosList.Count)
            return null;

        itemToReturn = _carPosList[carPosData.position].Key;

        return itemToReturn;
    }

    public void CheckpointTriggered(CarController car, int checkPointIndex)
    {

        PositionData carData = _carPositions[car];

        if (!_finished)
        {
            if (checkPointIndex == 0)
            {
                if (carData.lastCheckPoint == CheckPointList.Count() - 1)
                {
                    carData.lastCheckPoint = checkPointIndex;
                    carData.lap += 1;
                    //Debug.Log(car.name + " lap " + carData.lap);
                    if (IsPlayer(car))
                    {
                        GetComponent<RaceManager>().Announce("Tour " + (carData.lap + 1).ToString());
                    }

                    if (carData.lap >= _totalLaps)
                    {
                        _finished = true;
                        GetComponent<RaceManager>().EndRace(car.name.ToLower());
                    }
                }
            }
            else if (carData.lastCheckPoint == checkPointIndex - 1) //Checkpoints must be hit in order
            {
                carData.lastCheckPoint = checkPointIndex;
            }
        }

    }

    bool IsPlayer(CarController car)
    {
        return car.GetComponent<CarUserControlMP>() != null;
    }
}
