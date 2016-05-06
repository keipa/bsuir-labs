using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;

class Serializer
{
    Type TypeOfObject { get; set; }
    object ObjectToWrite { get; set; }
    List<object> assistantList;

    int CounterForReading { get; set; }

    public Serializer(object obj)
    {
        ObjectToWrite = obj;
        assistantList = new List<object>();
        writeObject(ObjectToWrite);
    }

    public Serializer()
    {
        CounterForReading = 0;
        assistantList = new List<object>();
    }



    public void writeToFile(object objectToWrite)
    {

        string path = "serialized.txt";
        FieldInfo[] fields = objectToWrite.GetType().GetFields(BindingFlags.GetField | BindingFlags.SetField |
            BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);

        int indexInList;
        if ((indexInList = assistantList.IndexOf(objectToWrite)) == -1)
        {
            assistantList.Add(objectToWrite);
            if (!objectToWrite.GetType().BaseType.Equals(typeof(MulticastDelegate)))
            {
                string s = objectToWrite.GetType().FullName;
                File.AppendAllText(path, TypeOfObject.FullName + "\n");
                if (objectToWrite.GetType().IsArray)
                {
                    foreach (object o in (Array)objectToWrite)
                    {
                        if (o != null)
                        {
                            File.AppendAllText(path, ((Array)objectToWrite).Length + "\n");
                            writeObject(o);
                        }
                    }
                }
                else if (objectToWrite.GetType().IsPrimitive || objectToWrite.GetType().Equals(typeof(string)))
                {
                    File.AppendAllText(path, objectToWrite.ToString() + "\n");
                }
                else
                {
                    foreach (FieldInfo field in fields)
                    {
                        writeObject(field.GetValue(objectToWrite));
                    }
                }
            }
        }
        else
        {
            File.AppendAllText(path, indexInList + "\n");
        }
    }

    public void writeToFile(string value)
    {
        using (StreamWriter sw = new StreamWriter("serialized"))
        {
            sw.WriteLine(TypeOfObject.FullName);
            sw.WriteLine(value);
        }
    }

    public void writeObject(object objectToWrite)
    {
        TypeOfObject = objectToWrite.GetType();
        writeToFile(objectToWrite);
    }


    public object readObject()
    {
        StreamReader file = new StreamReader("serialized.txt");

        for (int counter = 0; counter < CounterForReading; counter++)
            file.ReadLine(); //пропускаем уже считанные строки

        string line = file.ReadLine();
        CounterForReading++;

        Type typeOfCurrentObj = Type.GetType(line); //узнаем тип объекта


        object currentObj;
        
        if (typeOfCurrentObj.Equals(typeof(string))) //если строка
        {
            string value = file.ReadLine();
            CounterForReading++;
            //    currentObj = Activator.CreateInstance(typeOfCurrentObj, value); //создаем сам объект
            if (value.Equals("ref"))
            {
                currentObj = assistantList[Int32.Parse(file.ReadLine())];
                CounterForReading++;
            }
            else
            {
                currentObj = value;
            }
        }
        else if(typeOfCurrentObj.IsPrimitive) //если простой объект
        {
            currentObj = (object)typeOfCurrentObj.InvokeMember("Parse",//выполним parse 
              BindingFlags.InvokeMethod | BindingFlags.Static | BindingFlags.Public,
              null, null, new object[] { file.ReadLine() });
            assistantList.Add(currentObj);
            CounterForReading++;
        }
        else if (typeOfCurrentObj.IsArray) //массив
        {
            currentObj = Activator.CreateInstance(typeOfCurrentObj, Convert.ToInt32(file.ReadLine())); //создаем сам объект
            CounterForReading++;
            assistantList.Add(currentObj);

            for (int counter = 0; counter < ((Array)currentObj).Length; counter++)
            {
                ((Array)currentObj).SetValue(readObject(), counter);
            }
        }
        else //просто сложный объект
        {
            currentObj = Activator.CreateInstance(typeOfCurrentObj); //создаем сам объект
            assistantList.Add(currentObj);
            FieldInfo[] finfo = typeOfCurrentObj.GetFields(BindingFlags.GetField | BindingFlags.SetField |
                             BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance);
            foreach (FieldInfo field in finfo)
            {
                if (!field.FieldType.BaseType.Equals(typeof(MulticastDelegate)))
                {
                    field.SetValue(currentObj, readObject());
                }
            }
        }        
        return currentObj;
    }

}
