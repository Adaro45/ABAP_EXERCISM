
class BirdWatcher {
    private final int[] birdsPerDay;

    public BirdWatcher(int[] birdsPerDay) {
        this.birdsPerDay = birdsPerDay.clone();
    }

    public int[] getLastWeek() {
        return birdsPerDay;
    }

    public int getToday() {
        return birdsPerDay[6];
    }

    public void incrementTodaysCount() {
        birdsPerDay[6]++;
    }

public boolean hasDayWithoutBirds() {
    for (int i = 0; i <= 6; i++) {
        if (birdsPerDay[i] == 0) {
            return true;
        }
    }
    return false;
}

    public int getCountForFirstDays(int numberOfDays) {
        int cantTotal = 0;
        if(numberOfDays>7){
            for(int i =0; i<=6; i++){
                cantTotal+=birdsPerDay[i];
            }
        }else{
            for(int i =0; i<=numberOfDays-1; i++){
                cantTotal+=birdsPerDay[i];
            }
        }
        return cantTotal;
    }

    public int getBusyDays() {
        int busyDays = 0;
        for(int i =0; i<6; i++){
            if(birdsPerDay[i]>=5){
                busyDays++;
            }
        }
        return busyDays;
    }
}
