import * as chai from "chai";
import moment = require("moment");
import {Days, ScheduleCalendar} from "../../../src/gtfs/native/ScheduleCalendar";

describe("ScheduleCalendar", () => {

  xit("adds exclude days for bank holidays", () => {});

  it("detects overlaps", () => {
    const perm = calendar("2017-01-01", "2017-01-31");
    const underlay = calendar("2016-12-05", "2017-01-07");
    const innerlay = calendar("2017-01-05", "2017-01-07");
    const overlay = calendar("2017-01-31", "2017-02-07");
    const nolay = calendar("2017-02-05", "2017-02-07");

    chai.expect(underlay.overlaps(perm)).to.equal(true);
    chai.expect(innerlay.overlaps(perm)).to.equal(true);
    chai.expect(overlay.overlaps(perm)).to.equal(true);
    chai.expect(nolay.overlaps(perm)).to.equal(false);
  });

  it("does not detect overlaps when the days don't match", () => {
    const weekday = calendar("2017-01-01", "2017-01-31", { 1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 0, 7: 0 });
    const weekend = calendar("2017-01-01", "2017-01-31", { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 1, 7: 1 });
    const tuesday = calendar("2017-01-01", "2017-01-31", { 1: 0, 2: 1, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0 });

    chai.expect(weekend.overlaps(weekday)).to.equal(false);
    chai.expect(weekday.overlaps(weekend)).to.equal(false);
    chai.expect(tuesday.overlaps(weekday)).to.equal(true);
  });

  it("adds exclude days", () => {
    const perm = calendar("2017-01-01", "2017-01-31");
    const overlay = calendar("2017-01-30", "2017-02-07");

    perm.addExcludeDays(overlay);
    const excludeDays = Object.values(perm.excludeDays);

    chai.expect(excludeDays[0].toISOString()).to.deep.equal(moment("2017-01-30").toISOString());
    chai.expect(excludeDays[1].toISOString()).to.deep.equal(moment("2017-01-31").toISOString());
  });

  it("adds exclude days only within the range of the original date range", () => {
    const perm = calendar("2017-01-05", "2017-01-31");
    const underlay = calendar("2017-01-01", "2017-01-07");
    const overlay = calendar("2017-01-30", "2017-02-07");

    perm.addExcludeDays(underlay);
    perm.addExcludeDays(overlay);
    const excludeDays = Object.values(perm.excludeDays);

    chai.expect(excludeDays[0].toISOString()).to.deep.equal(moment("2017-01-05").toISOString());
    chai.expect(excludeDays[1].toISOString()).to.deep.equal(moment("2017-01-06").toISOString());
    chai.expect(excludeDays[2].toISOString()).to.deep.equal(moment("2017-01-07").toISOString());
    chai.expect(excludeDays[3].toISOString()).to.deep.equal(moment("2017-01-30").toISOString());
    chai.expect(excludeDays[4].toISOString()).to.deep.equal(moment("2017-01-31").toISOString());
  });

  it("divides around a date range spanning the beginning", () => {
    const perm = calendar("2017-01-05", "2017-01-31");
    const underlay = calendar("2017-01-01", "2017-01-07");

    const calendars = perm.divideAround(underlay);
    chai.expect(calendars[0].runsFrom.toISOString()).to.deep.equal(moment("2017-01-08").toISOString());
    chai.expect(calendars[0].runsTo.toISOString()).to.deep.equal(moment("2017-01-31").toISOString());
  });

  it("divides around a date range spanning the end", () => {
    const perm = calendar("2017-01-05", "2017-01-31");
    const underlay = calendar("2017-01-29", "2017-02-07");

    const calendars = perm.divideAround(underlay);
    chai.expect(calendars[0].runsFrom.toISOString()).to.deep.equal(moment("2017-01-05").toISOString());
    chai.expect(calendars[0].runsTo.toISOString()).to.deep.equal(moment("2017-01-28").toISOString());
  });

  it("divides around a date range in the middle", () => {
    const perm = calendar("2017-01-05", "2017-01-31");
    const underlay = calendar("2017-01-15", "2017-01-20");

    const calendars = perm.divideAround(underlay);
    chai.expect(calendars[0].runsFrom.toISOString()).to.deep.equal(moment("2017-01-05").toISOString());
    chai.expect(calendars[0].runsTo.toISOString()).to.deep.equal(moment("2017-01-14").toISOString());
    chai.expect(calendars[1].runsFrom.toISOString()).to.deep.equal(moment("2017-01-21").toISOString());
    chai.expect(calendars[1].runsTo.toISOString()).to.deep.equal(moment("2017-01-31").toISOString());
  });

});

function calendar(from: string, to: string, days: Days = { 1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 1, 7: 1 }): ScheduleCalendar {
  return new ScheduleCalendar(
    moment(from),
    moment(to),
    days,
    1,
    {}
  );
}